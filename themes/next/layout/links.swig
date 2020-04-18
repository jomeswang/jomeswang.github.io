{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}

    <div id="links">
        <style>

            #links{
               margin-top: 5rem;
            }

            .links-content{
                margin-top:1rem;
            }

            .link-navigation::after {
                content: " ";
                display: block;
                clear: both;
            }

            .card {
                width: 300px;
                font-size: 1rem;
                padding: 0px;
                border-radius: 4px;
                transition-duration: 0.15s;
                margin-bottom: 1rem;
                display:flex;
            }
            .card:nth-child(odd) {
                float: left;
            }
            .card:nth-child(even) {
                float: right;
            }
            .card:hover {
                transform: scale(1.1);
                box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.12), 0 0 6px 0 rgba(0, 0, 0, 0.04);
            }
            .card a {
                border:none;
            }
            .card .ava {
                width: 3rem!important;
                height: 3rem!important;
                margin:0!important;
                margin-right: 1em!important;
                border-radius:4px;

            }
            .card .card-header {
                font-style: italic;
                overflow: hidden;
                width: 236px;
            }
            .card .card-header a {
                font-style: normal;
                color: #2bbc8a;
                font-weight: bold;
                text-decoration: none;
            }
            .card .card-header a:hover {
                color: #d480aa;
                text-decoration: none;
            }
            .card .card-header .info {
                font-style:normal;
                color:#a3a3a3;
                font-size:14px;
                min-width: 0;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .note.success{
                line-height: 2;
                font-family: eb garamond,"noto serif sc",sans-serif;
                color: #000;
                cursor: url(/images/default.cur),auto;
                position: relative;
                padding: 15px;
                margin-bottom: 20px;
                border: initial;
                border-left: 3px solid #eee;
                border-radius: 3px;
                font-size: 15px;
                padding-left: 45px;
                background-color: #eff8f0;
                border-left-color: #5cb85c;
            }
            .note danger{
                line-height: 2;
                font-family: eb garamond,"noto serif sc",sans-serif;
                color: #000;
                cursor: url(/images/default.cur),auto;
                position: relative;
                padding: 15px;
                margin-bottom: 20px;
                border: initial;
                border-left: 3px solid #eee;
                border-radius: 3px;
                font-size: 15px;
                padding-left: 45px;
                background-color: #fcf1f2;
                border-left-color: #d9534f;
            }
        </style>
        <div class="links-content">
            <div class="link-navigation">

                {% for link in theme.mylinks %}

                    <div class="card">
                        <img class="ava" src="{{ link.avatar }}"/>
                        <div class="card-header">
                           <div>
                              <a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a>
                           </div>
                           <div class="info">{{ link.info }}</div>
                        </div>
                    </div>

                {% endfor %}

            
            </div>
            {{ page.content }}
            </div>
            <hr>

            <div class="note success"><p><strong class="cf-tweet-this cf-tt-target cf-tt-abutted cf-tt-abutted-top cf-tt-out-of-bounds cf-tt-out-of-bounds-bottom cf-tt-element-attached-bottom cf-tt-element-attached-center cf-tt-target-attached-top cf-tt-target-attached-center">友链格式</strong>
            <br>名称：传道士<br>描述：三生万物，万物归一<br>网址：<a href="https://hexo.jomeswang.top">https://hexo.jomeswang.top</a>
            <br>头像：<a href="http://photo.jomeswang.top/20200405170507.png">http://photo.jomeswang.top/20200405170507.png</a></p></div>
            <div class="note danger"><p><strong>申请要求</strong>
            <br>谷歌、百度等搜索引擎收录<br>无广告推广，头像外链不 403<br>个人域名非商业网站</p></div>
        </div>

  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}