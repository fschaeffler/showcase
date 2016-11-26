#!/bin/bash
sudo apt-get update
sudo apt-get upgrade

# ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
source /home/ubuntu/.rvm/scripts/rvm
rvm install ruby-2.3.1
gem install bundle rails

# nodejs
sudo apt-get install build-essential libssl-dev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 4

# app
cd ~; git clone https://github.com/fschaeffler/showcase
sudo apt-get install libmysqlclient-dev
bundle
rake db:migrate RAILS_ENV=development

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

sudo cp nginx-default /etc/nginx/sites-available/default
sudo service nginx restart

# app server
cd ~/showcase

cat > nginx-default <<EOL
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  pool: 5
  database: showcase
  username: showcase
  password: xbSyea2U82tgJhb6
  host: 
EOL

export AMAZON_ACCESS_KEY=''
export AMAZON_SECRET_KEY=''

rails server