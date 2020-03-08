# 申请let's encrpy credentials

前提：

需要将cf的api_key，email提前export到环境中

`api_key`：cf的Global API Key

`email`：cf的email

~~~bash
curl -k -o letsencrpy_credentials_install.sh "https://raw.githubusercontent.com/weiguangchao/Linux_script/master/letsencrpy_credentials_install.sh" && chmod +x letsencrpy_credentials_install.sh && ./letsencrpy_credentials_install.sh your domain
~~~

your domain：多个域名使用空格进行分割

在脚本执行过程中会再次输入域名进行确认，多个域名可以使用逗号或空格进行分割

# 安装docker 及 docker-compose

~~~bash
curl -k -o docker_install.sh "https://raw.githubusercontent.com/weiguangchao/Linux_script/master/docker_install.sh" && chmod +x docker_install.sh  && ./docker_install.sh 
~~~

若使用非root用户，为了不影响docker的使用，请将当前用户添加到docker用户组里

# 初始化Hexo博客的Git仓库

~~~bash
curl -k -o hexo_blog_git.sh "https://raw.githubusercontent.com/weiguangchao/Linux_script/master/hexo_blog_git.sh" && chmod +x hexo_blog_git.sh && ./hexo_blog_git.sh
~~~

博客Git仓库位于`~/blog.git`，html代码位于`~/data/www`，同时会开启`80`和`443`端口

# 网络优化

来自[千影](https://github.com/chiakge/Linux-NetSpeed)的优化脚本

~~~bash
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" &&
chmod +x tcp.sh &&
./tcp.sh
~~~

