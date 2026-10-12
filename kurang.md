# Yang masih kurang (Calculadora de Porcentagem)

Dibuat pada 2026-10-12. Status proyek: kode dan konten selesai, tetapi belum pernah dibangun dengan Hugo.

## 1. Wajib dilakukan sebelum publikasi

- [X] **File font Inter** belum ada di `static/fonts/inter-latin-var.woff2`. Jalankan `sh scripts/get-inter.sh` dengan internet. Tanpa file ini, browser memakai font cadangan dan ada error 404 pada preload.
- [X] **Email kontak** belum diisi (`params.email` di `hugo.toml`). Halaman Contato dan Privacidade menampilkan teks pengingat sampai diisi.
- [ ] **AdSense** belum dikonfigurasi (`adsenseClient` dan `adsenseSlot` kosong), jadi belum ada iklan yang tampil.
- [X] **Build Hugo pertama**: jalankan `hugo --minify` (Hugo extended 0.128 atau lebih baru) dan perbaiki error template jika ada.
- [ ] **Nama situs/penerbit** untuk halaman Sobre dan skema Organization belum Anda tentukan (sekarang memakai "Calculadora de Porcentagem").
- [ ] **Akun/organisasi GitHub** bernama persis `calculadora-de-porcentagem` diperlukan agar baseURL `calculadora-de-porcentagem.github.io` valid. Repository belum dibuat (sesuai instruksi).

## 2. Belum diverifikasi

- [X] **Core Web Vitals 100**: belum diukur. Jalankan Lighthouse (mobile) pada build asli, dengan dan tanpa iklan.
- [ ] **JSON-LD**: belum divalidasi. Cek dengan validator.schema.org dan Rich Results Test setelah build.
- [X] **Template Hugo** belum dijalankan (Hugo tidak ada di lingkungan pembuatan). Risiko terbesar ada di `schema.html` dan `breadcrumb.html`.
- [ ] **Tiga URL sumber** belum dibuka satu per satu: `Markup_(business)`, `Profit_margin`, `Tangent_(trigonometry)` di en.wikipedia.org. Cek juga semua link keluar dengan link checker setelah build.
- [ ] **Urutan kalkulator "paling populer"** adalah perkiraan, belum dicek dengan Google Trends/Keyword Planner untuk Brasil.
- [ ] **Tampilan** di perangkat nyata (mobile, desktop) belum dilihat, termasuk navbar yang hanya membungkus baris, tanpa menu hamburger.

## 3. Belum ada di proyek

- [ ] **Banner persetujuan cookie** (diperlukan untuk iklan yang dipersonalisasi di sebagian wilayah). Teks privasi baru berupa draf umum.
- [ ] **Gambar OG/favicon file**: sekarang hanya favicon SVG inline dan kartu Twitter `summary` tanpa gambar.
- [ ] **Workflow deploy GitHub Pages** (GitHub Actions) belum dibuat.
- [ ] **Verifikasi Search Console dan Bing Webmaster**, serta kunci IndexNow, belum ada.
- [ ] **Logo, `sameAs`, nama penulis**: skema Organization masih minimal, dan tidak ada profil penulis untuk sinyal E-E-A-T.
- [ ] **Style cetak** dan tes aksesibilitas formal (axe/WAVE) belum dibuat.

## 4. Kualitas konten

- [ ] **Panjang halaman glosarium**: rata-rata sekitar 87 kata (terpendek 58, terpanjang 129); 39 dari 39 halaman di bawah 150 kata. Perlu diperpanjang jika ingin menghindari kesan thin content, terutama untuk persetujuan AdSense.
- [ ] **Sumber hampir semuanya Wikipedia**. Tambahkan sumber lain (mis. Banco Central do Brasil untuk juros, BIPM untuk SI) bila ingin lebih beragam.
- [ ] **Tinjauan penutur asli pt-BR** untuk artikel homepage, FAQ, dan 39 verbete belum dilakukan.
- [ ] **Teks legal** (privasi, termos) perlu ditinjau ahli sebelum dipakai secara resmi.
- [ ] **Risiko AdSense di `*.github.io`**: sepengetahuan saya, subdomain gratis biasanya tidak disetujui. Cek kebijakan terbaru dan pertimbangkan custom domain.
- [ ] **Google FAQ rich result** sangat dibatasi untuk situs umum. Skema FAQPage tetap berguna untuk mesin AI, tetapi jangan berharap tampil sebagai rich result.
