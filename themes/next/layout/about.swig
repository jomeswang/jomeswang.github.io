{% block content %}
  {######################}
  {### ABOUT BLOCK ###}
  {######################}

    <div id="about">
        <style>

            #about{
               margin-top: 5rem;
            }
            .blockquote-center{
                 font-size: 1em;
                line-height: 2;
                font-family: 'Noto Serif SC', "PingFang SC", "Microsoft YaHei", sans-serif;
                overflow-wrap: break-word;
                color: #666;
                border-left: none;
                margin: 40px 0;
                padding: 0;
                position: relative;
                text-align: center;
            }
            .note primary{
                font-size: 1em;
                line-height: 2;
                color: #000;
                font-family: 'Noto Serif SC', "PingFang SC", "Microsoft YaHei", sans-serif;
                overflow-wrap: break-word;
                text-align: justify;
                border-radius: 3px;
                margin-bottom: 20px;
                padding: 15px;
                position: relative;
                border: initial;
                border-left: 3px solid #eee;
                padding-left: 45px;
                background: #f5f0fa;
                border-left-color: #6f42c1;
            }
            .note info{
                font-size: 1em;
                line-height: 2;
                color: #000;
                font-family: 'Noto Serif SC', "PingFang SC", "Microsoft YaHei", sans-serif;
                overflow-wrap: break-word;
                text-align: justify;
                border-radius: 3px;
                margin-bottom: 20px;
                padding: 15px;
                position: relative;
                border: initial;
                border-left: 3px solid #eee;
                padding-left: 45px;
                background: #eef7fa;
                border-left-color: #428bca;
            }
            .note success{
                font-size: 1em;
                line-height: 2;
                color: #000;
                font-family: 'Noto Serif SC', "PingFang SC", "Microsoft YaHei", sans-serif;
                overflow-wrap: break-word;
                text-align: justify;
                border-radius: 3px;
                margin-bottom: 20px;
                padding: 15px;
                position: relative;
                border: initial;
                border-left: 3px solid #eee;
                padding-left: 45px;
                background: #eff8f0;
                border-left-color: #5cb85c;
            }
        </style>
        <div class="about-content">
            <div class="about-navigation">

                <blockquote class="blockquote-center"><p>希望能在最美好的年代遇见最美的你</p></blockquote>
                <hr>
                <div class="note primary">
                <h2 id="基础信息"><a href="#基础信息" class="headerlink" title="基础信息"></a>基础信息</h2><ul><li>GitHub：<a href="https://github.com/jomeswang" target="_blank" rel="noopener external nofollow noreferrer">https://github.com/jomeswang</a></li><li> 坐标：深圳</li><li>一个正在征途路上勇敢前进的小伙子</li></ul>
                </div>
                <div class="note info">
                <h2 id="兴趣爱好"><a href="#兴趣爱好" class="headerlink" title="兴趣爱好"></a>兴趣爱好</h2><ul><li>跑步</li><li>吹水</li></ul>
                </div>
                <div class="note success">
                 <h2 id="更新日志"><a href="#更新日志" class="headerlink" title="更新日志"></a>更新日志</h2>
                 <ul>
                    {% for fplan in theme.fplans %}
                        <li>{{ fplan.time}}---{{ fplan.plan }}</li>
                                                        
                     {% endfor %}
                 </ul>
                </div>
                <div class="note warning">
                    <h2 id="待办事项"><a href="#待办事项" class="headerlink" title="待办事项"></a>待办事项</h2>
                    <ul>
                    {% for uplan in theme.uplans %}
                        <li>{{ uplan.plan }}</li>
                                                        
                     {% endfor %}
                 </ul>
                </div>

            </div>
            {{ page.content }}
            </div>
        </div>

  {##########################}
  {### END ABOUT BLOCK ###}
  {##########################}
{% endblock %}