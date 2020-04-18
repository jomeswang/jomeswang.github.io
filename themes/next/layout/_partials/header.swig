<div class="site-brand-wrapper">
  <div class="site-meta {% if theme.custom_logo.enabled %}custom-logo{% endif %}">
    {% if theme.custom_logo.image and theme.scheme === 'Muse' %}
      <div class="site-meta-headline">
        <a>
          <img class="custom-logo-image" src="{{ theme.custom_logo.image }}"
               alt="{{ config.title }}"/>
        </a>
      </div>
    {% endif %}

    <div class="custom-logo-site-title">
      <a href="{{ config.root }}"  class="brand" rel="start">
        <span class="logo-line-before"><i></i></span>
        <span class="site-title">{{ config.title }}</span>
        <span class="logo-line-after"><i></i></span>
      </a>
    </div>
      {% if theme.seo %}
        <h1 class="site-subtitle" itemprop="description">{{ config.subtitle }}</h1>
      {% else %}
        <p class="site-subtitle">{{ config.subtitle }}</p>
      {% endif %}


    <!-- 滚动文字始  -->
      <div id="binft" style="color: #191970"; ></div>
          <script>
            var binft = function (r) {
              function t() {
                return b[Math.floor(Math.random() * b.length)]
              }  
              function e() {
                return String.fromCharCode(94 * Math.random() + 33)
              }
              function n(r) {
                for (var n = document.createDocumentFragment(), i = 0; r > i; i++) {
                  var l = document.createElement("span");
                  l.textContent = e(), l.style.color = t(), n.appendChild(l)
                }
                return n
              }
              function i() {
                var t = o[c.skillI];
                c.step ? c.step-- : (c.step = g, c.prefixP < l.length ? (c.prefixP >= 0 && (c.text += l[c.prefixP]), c.prefixP++) : "forward" === c.direction ? c.skillP < t.length ? (c.text += t[c.skillP], c.skillP++) : c.delay ? c.delay-- : (c.direction = "backward", c.delay = a) : c.skillP > 0 ? (c.text = c.text.slice(0, -1), c.skillP--) : (c.skillI = (c.skillI + 1) % o.length, c.direction = "forward")), r.textContent = c.text, r.appendChild(n(c.prefixP < l.length ? Math.min(s, s + c.prefixP) : Math.min(s, t.length - c.skillP))), setTimeout(i, d)
              }
              var l = "",
              o = ["图难于其易，为大于其细。", "天下之难事，必作于易。","天下之大事，必作于细。", "道生一，一生二。","二生三，三生万物。","昨夜西风凋碧树。","独上高楼，望尽天涯路。","衣带渐宽终不悔，为伊消得人憔悴。","众里寻他千百度，蓦然回首","那人却在，灯火阑珊处。"].map(function (r) {
              return r + ""
              }),
              a = 2,
              g = 1,
              s = 5,
              d = 75,
              b = ["rgb(110,64,170)", "rgb(150,61,179)", "rgb(191,60,175)", "rgb(228,65,157)", "rgb(254,75,131)", "rgb(255,94,99)", "rgb(255,120,71)", "rgb(251,150,51)", "rgb(226,183,47)", "rgb(198,214,60)", "rgb(175,240,91)", "rgb(127,246,88)", "rgb(82,246,103)", "rgb(48,239,130)", "rgb(29,223,163)", "rgb(26,199,194)", "rgb(35,171,216)", "rgb(54,140,225)", "rgb(76,110,219)", "rgb(96,84,200)"],
              c = {
                text: "",
                prefixP: -s,
                skillI: 0,
                skillP: 0,
                direction: "forward",
                delay: a,
                step: g
              };
              i()
              };
              binft(document.getElementById('binft'));
          </script>
  </div>

<!-- 滚动文字终  -->

  <div class="site-nav-toggle">
    <button>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
    </button>
  </div>
</div>

<nav class="site-nav">
  {% set hasSearch = theme.swiftype_key || theme.algolia_search.enable || theme.tinysou_Key || theme.local_search.enable %}

  {% if theme.menu %}
    <ul id="menu" class="menu">
      {% for name, path in theme.menu %}
        {% set itemName = name.toLowerCase() %}
        <li class="menu-item menu-item-{{ itemName | replace(' ', '-') }}">
          <a href="{{ url_for(path.split('||')[0]) | trim }}" rel="section">
            {% if theme.menu_icons.enable %}
              <i class="menu-item-icon fa fa-fw fa-{{ path.split('||')[1] | trim | default('question-circle') }}"></i> <br />
            {% endif %}
            {{ __('menu.' + name) | replace('menu.', '') }}
          </a>
        </li>
      {% endfor %}

      {% if hasSearch %}
        <li class="menu-item menu-item-search">
          {% if theme.swiftype_key %}
            <a href="javascript:;" class="st-search-show-outputs">
          {% elseif theme.local_search.enable || theme.algolia_search.enable %}
            <a href="javascript:;" class="popup-trigger">
          {% endif %}
            {% if theme.menu_icons.enable %}
              <i class="menu-item-icon fa fa-search fa-fw"></i> <br />
            {% endif %}
            {{ __('menu.search') }}
          </a>
        </li>
      {% endif %}
    </ul>
  {% endif %}

  {% if hasSearch %}
    <div class="site-search">
      {% include 'search.swig' %}
    </div>
  {% endif %}
</nav>

{% include '../_custom/header.swig' %}
