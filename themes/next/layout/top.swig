{% block content %}
  {######################}
  {### ABOUT BLOCK ###}
  {######################}


<div id="top"></div>
<script src="//code.bdstatic.com/npm/leancloud-storage@4.12.0/dist/av-min.js"></script>
<script>AV.init({
  appId: "{{theme.leancloud_visitors.app_id}}",
  appKey: "{{theme.leancloud_visitors.app_key}}",
  serverURL: "{{theme.leancloud_visitors.server_url}}"
});</script>
<script type="text/javascript">
  var time=0
  var title=""
  var url=""
  var query = new AV.Query('Counter');
  query.notEqualTo('id',0);
  query.descending('time');
  query.limit(15);
  query.find().then(function (todo) {
    for (var i=0;i<15;i++){
      var result=todo[i].attributes;
      time=result.time;
      title=result.title;
      url=result.url;
      // var content="<a href='"+"https://hoxis.github.io"+url+"'>"+title+"</a>"+"<br>"+"<font color='#fff'>"+"阅读次数："+time+"</font>"+"<br><br>";
      var content="<p>"+"<font color='#1C1C1C'>"+"【文章热度:"+time+"℃】"+"</font>"+"<a href='"+"https://hexo.jomeswang.top"+url+"'>"+title+"</a>"+"</p>";
      document.getElementById("top").innerHTML+=content
    }
  }, function (error) {
    console.log("error");
  });
</script>

  {##########################}
  {### END ABOUT BLOCK ###}
  {##########################}
{% endblock %}