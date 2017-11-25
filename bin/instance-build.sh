#!/bin/bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

# ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
source /home/ubuntu/.rvm/scripts/rvm
rvm install ruby-2.4.1
gem install bundle

# nodejs
sudo apt-get install build-essential libssl-dev openjdk-8-jdk -y
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 8

# app
cd ~; git clone https://github.com/fschaeffler/showcase; cd showcase
sudo apt-get install libmysqlclient-dev -y
bundle

# web server
sudo apt-get install nginx -y

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
export AMAZON_ACCESS_KEY=''
export AMAZON_SECRET_KEY=''

echo ""
echo "!!! PLEASE UPDATE THE 'CHANGE_ME' entries in config/database.yml"
echo "!!! AFTERWARDS A 'bin/rails db:migrate RAILS_ENV=development' IS NEEDED"
echo "!!! AFTERWARDS A 'bin/rails server' IS NEEDED"
