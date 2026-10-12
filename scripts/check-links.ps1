# check-links.ps1
# Cek semua internal link di situs Hugo (http://localhost:1313)
# Jalankan saat `hugo server` sedang aktif.

param(
    [string]$BaseUrl   = "http://localhost:1313",
    [int]   $TimeoutSec = 10
)

$ErrorActionPreference = "Stop"

# ─── helpers ──────────────────────────────────────────────────────────────────

function Get-Html($url) {
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec $TimeoutSec
        return [pscustomobject]@{ Status = $r.StatusCode; Body = $r.Content }
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        $statusCode = if ($code) { $code } else { 0 }
        return [pscustomobject]@{ Status = $statusCode; Body = "" }
    }
}

function Extract-Links($html, $pageUrl) {
    $links = [System.Collections.Generic.HashSet[string]]::new()
    $rx    = [regex]'href="([^"#?][^"]*)"'
    foreach ($m in $rx.Matches($html)) {
        $href = $m.Groups[1].Value.Trim()
        if ($href -eq "" -or $href.StartsWith("mailto:") -or $href.StartsWith("tel:") -or $href.StartsWith("data:")) { continue }

        # absolut eksternal → skip
        if ($href -match '^https?://' -and -not $href.StartsWith($BaseUrl)) { continue }

        # jadikan URL lengkap
        if ($href.StartsWith($BaseUrl)) {
            $full = $href
        } elseif ($href.StartsWith("/")) {
            $full = $BaseUrl + $href
        } else {
            # relatif → resolve terhadap halaman saat ini
            $base = $pageUrl -replace '/[^/]*$', '/'
            $full = $base + $href
        }

        # buang fragment dan query
        $full = ($full -split '[?#]')[0].TrimEnd('/')
        if ($full -ne "") { [void]$links.Add($full) }
    }
    return $links
}

# ─── main ─────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "🔍  Internal Link Checker — $BaseUrl" -ForegroundColor Cyan
Write-Host "────────────────────────────────────────────────────────────" -ForegroundColor DarkGray

$visited    = [System.Collections.Generic.HashSet[string]]::new()
$queue      = [System.Collections.Generic.Queue[string]]::new()
$broken     = [System.Collections.Generic.List[pscustomobject]]::new()
$checkedCount = 0

$startUrl = $BaseUrl.TrimEnd('/')
[void]$visited.Add($startUrl)
$queue.Enqueue($startUrl)

while ($queue.Count -gt 0) {
    $url = $queue.Dequeue()
    $checkedCount++

    $resp = Get-Html $url
    $status = $resp.Status
    $ok     = ($status -ge 200 -and $status -lt 300)

    if (-not $ok) {
        $broken.Add([pscustomobject]@{ URL = $url; Status = $status })
        Write-Host "  ❌  [$status]  $url" -ForegroundColor Red
    } else {
        Write-Host "  ✅  [$status]  $url" -ForegroundColor Green

        # ekstrak link baru hanya dari halaman yang sukses
        $newLinks = Extract-Links $resp.Body $url
        foreach ($link in $newLinks) {
            if (-not $visited.Contains($link)) {
                [void]$visited.Add($link)
                $queue.Enqueue($link)
            }
        }
    }
}

# ─── ringkasan ────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "  Total halaman diperiksa : $checkedCount" -ForegroundColor White
Write-Host "  Link broken / error     : $($broken.Count)" -ForegroundColor $(if ($broken.Count -gt 0) { "Red" } else { "Green" })

if ($broken.Count -gt 0) {
    Write-Host ""
    Write-Host "  ⚠️  Daftar link bermasalah:" -ForegroundColor Yellow
    foreach ($b in $broken) {
        Write-Host "       [$($b.Status)]  $($b.URL)" -ForegroundColor Red
    }
    Write-Host ""
    exit 1
} else {
    Write-Host ""
    Write-Host "  🎉  Semua internal link OK, tidak ada yang 404!" -ForegroundColor Green
    Write-Host ""
    exit 0
}
