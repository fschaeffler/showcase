#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y

# ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
source /home/ubuntu/.rvm/scripts/rvm
rvm install ruby-2.4.1
gem install bundle

# nodejs
sudo apt-get install build-essential libssl-dev libmysqlclient-dev openjdk-8-jdk
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 8

# app
cd ~; git clone https://github.com/fschaeffler/showcase
sudo apt-get install libmysqlclient-dev
bundle
bundle exec rails db:migrate RAILS_ENV=development

# web server
sudo apt-get install nginx

cat > nginx-default <<EOL
upstream app {
  server localhost:3000;
}

server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /home/ubuntu/showcase;

  try_files \$uri/index.html \$uri @app;

  server_name _;

  location @app {
    proxy_set_header Host \$host;
    proxy_pass http://app;
  }
}
EOL

sudo mv nginx-default /etc/nginx/sites-available/default
sudo service nginx restart

# app server
cd ~/showcase

echo "Please sepecify mysql database host"
read DB_HOST
echo "Please sepecify mysql database username"
read DB_USERNAME
echo "Please sepecify mysql database password"
read DB_PASSWORD

cat > config/database.yml <<EOL
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  pool: 5
  database: showcase
  username: $DB_HOST
  password: $DB_USERNAME
  host: $DB_PASSWORD
EOL

export AMAZON_ACCESS_KEY=''
export AMAZON_SECRET_KEY=''

bundle exec rails server