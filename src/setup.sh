
set -euv

# Install ruby 2.5, rails stuff, nokogiri stuff.
# apt-add-repository -y ppa:rael-gc/rvm
apt-get update
apt-get install -y sqlite3 libsqlite3-dev nodejs build-essential patch zlib1g-dev liblzma-dev autoconf bison libssl-dev libyaml-dev libreadline6-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
# $(rbenv init -)
# source ~/.bashrc

# type rbenv

# OK, try the "ubuntu rvm"
# https://github.com/rvm/ubuntu_rvm
#  apt-get install software-properties-common
# apt-get install -y rvm
# echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
# This should be what's need to use rvm?
# /bin/bash --login
# source ~/.bashrc
# which rvm
# rvm requirements
# rvm install 2.6.5
# rvm use 2.6.5

# gem install rails -v 5.2.4.4 --no-ri --no-doc
