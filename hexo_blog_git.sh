#!/bin/bash
user_home=~

git_blog_location="${user_home}/blog.git"
www_blog_location="${user_home}/data/www"

sudo yum install git -y

mkdir -p ${www_blog_location}
mkdir -p ${git_blog_location}
cd ${git_blog_location}
git init --bare
touch ${git_blog_location}/hooks/post-receive
cat >${git_blog_location}/hooks/post-receive <<EOF
#!/bin/bash
git --work-tree=${www_blog_location} --git-dir=${git_blog_location} checkout -f
EOF

chmod +x ${git_blog_location}/hooks/post-receive

sudo systemctl start firewalld
sudo systemctl status firewalld
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=443/tcp --permanent
sudo firewall-cmd --reload
