var spawn = require('child_process').spawn;
hexo.on('new', function(data){
    spawn('D:/Program Files/Typora/Typora.exe ', [data.path]);
});
