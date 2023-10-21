#!/bin/bash

# install system dependencies
sudo apt-get update
sudo apt-get install git gnupg curl vim net-tools -y

# install ruby via rvm
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME/.rvm/scripts/rvm
rvm install "ruby-2.5.1"

# install nodejs via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 8

# prepare showcase-app
sudo apt-get install libmysqlclient-dev -y
git clone https://github.com/fschaeffler/showcase.git; cd showcase
bundle