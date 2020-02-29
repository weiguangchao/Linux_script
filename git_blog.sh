#!/bin/bash
user_hoem=~

git_blog_location="${user_hoem}/blog.git"
www_blog_location="${user_hoem}/data/www"

echo "1. 安装Git"
sudo yum install git -y

echo "2. 设置博客的Git"
mkdir -p ${www_blog_location}
mkdir -p ${git_blog_location}
cd ${git_blog_location}
git init --bare
echo -e "#!/bin/sh\nWWW=${www_blog_location}\nGIT_REPO=${git_blog_location}\ngit --work-tree=\${WWW} --git-dir=\${GIT_REPO} checkout -f" > ${git_blog_location}/hooks/post-receive
chmod +x ${git_blog_location}/hooks/post-receive

echo "3. 开放端口"
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --reload