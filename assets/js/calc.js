(function () {
  var nf = new Intl.NumberFormat("pt-BR", { maximumFractionDigits: 2 });
  function f(n) { return isFinite(n) ? nf.format(n) : "–"; }
  function num(v) {
    v = (v || "").trim().replace(/\s/g, "");
    if (!v) return NaN;
    if (v.indexOf(",") > -1) v = v.replace(/\./g, "").replace(",", ".");
    else if (/^\d{1,3}(\.\d{3})+$/.test(v)) v = v.replace(/\./g, "");
    return Number(v);
  }
  var ok = function () {
    for (var i = 0; i < arguments.length; i++) if (!isFinite(arguments[i])) return false;
    return true;
  };
  var C = {
    "quanto-e": function (a, b) {
      if (!ok(a, b)) return;
      var r = a * b / 100;
      return [f(r), f(a) + "% de " + f(b) + " é " + f(r)];
    },
    "quantos-por-cento": function (a, b) {
      if (!ok(a, b) || b === 0) return;
      var r = a / b * 100;
      return [f(r) + "%", f(a) + " é " + f(r) + "% de " + f(b)];
    },
    "desconto": function (a, b) {
      if (!ok(a, b)) return;
      var p = a * (1 - b / 100);
      return [f(p), "Desconto de " + f(a - p) + " sobre " + f(a) + ". Preço final: " + f(p)];
    },
    "aumento": function (a, b) {
      if (!ok(a, b)) return;
      var p = a * (1 + b / 100);
      return [f(p), "Acréscimo de " + f(p - a) + " sobre " + f(a) + ". Valor final: " + f(p)];
    },
    "variacao": function (a, b) {
      if (!ok(a, b) || a === 0) return;
      var r = (b - a) / a * 100;
      return [(r > 0 ? "+" : "") + f(r) + "%", (r >= 0 ? "Aumento" : "Redução") + " de " + f(a) + " para " + f(b)];
    },
    "valor-total": function (a, b) {
      if (!ok(a, b) || b === 0) return;
      var r = a / b * 100;
      return [f(r), f(a) + " é " + f(b) + "% de " + f(r)];
    },
    "margem-markup": function (a, b) {
      if (!ok(a, b) || a <= 0 || b === 0) return;
      var l = b - a;
      return ["Margem de " + f(l / b * 100) + "%", "Markup de " + f(l / a * 100) + "%. Lucro de " + f(l) + " por unidade"];
    },
    "porcentagem-de-porcentagem": function (a, b, c) {
      if (!ok(a, b)) return;
      var r = a * b / 100;
      var s = f(a) + "% de " + f(b) + "% é " + f(r) + "%";
      if (ok(c)) s += ". Sobre " + f(c) + ", isso dá " + f(c * r / 100);
      return [f(r) + "%", s];
    },
    "regra-de-tres": function (a, b, c) {
      if (!ok(a, b, c) || a === 0) return;
      var x = b * c / a;
      return [f(x), f(a) + " está para " + f(b) + " assim como " + f(c) + " está para " + f(x)];
    }
  };
  document.querySelectorAll("[data-calc]").forEach(function (sec) {
    var fn = C[sec.getAttribute("data-calc")];
    var out = sec.querySelector(".res");
    var empty = out.innerHTML;
    var inputs = sec.querySelectorAll("[data-k]");
    function run() {
      var v = {};
      inputs.forEach(function (i) { v[i.getAttribute("data-k")] = num(i.value); });
      var r = fn && fn(v.a, v.b, v.c);
      out.innerHTML = r ? "<strong>" + r[0] + "</strong><span>" + r[1] + "</span>" : empty;
    }
    inputs.forEach(function (i) { i.addEventListener("input", run); });
  });
})();
