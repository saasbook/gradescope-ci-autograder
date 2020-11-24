
set -euv

# Install ruby 2.5, rails stuff, nokogiri stuff.
apt-get update
apt-get install -y sqlite3 libsqlite3-dev nodejs build-essential patch ruby-dev zlib1g-dev liblzma-dev

# Basic gem utils, if an assignment doesn't use a Gemfile
gem install -N bundler
gem update --system

mkdir ~/.gnupg
echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby

set +o nounset
source /etc/profile.d/rvm.sh
source /usr/local/rvm/scripts/rvm

rvm requirements

rvm install 2.6.5
gem install rails -v 5.2.4.4
