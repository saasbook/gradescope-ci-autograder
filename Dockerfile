FROM travisci/ubuntu-ruby:18.04

FROM gradescope/auto-builds:latest

# A bunch of Ubuntu deps
RUN apt-add-repository -y ppa:rael-gc/rvm
RUN apt-get update
RUN apt-get install software-properties-common
RUN apt-get install -y sqlite3 libsqlite3-dev nodejs build-essential patch zlib1g-dev liblzma-dev autoconf bison libssl-dev libyaml-dev libreadline6-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev

# Travis and Ruby utils
RUN apt-get install -y ruby

RUN echo 'gem: --no-document' >> /etc/gemrc

RUN gem install travis
RUN git clone https://github.com/travis-ci/travis-build
RUN cd travis-build
RUN mkdir -p ~/.travis
RUN ln -s $PWD ~/.travis/travis-build
RUN gem install bundler
# RUN bundle install --gemfile ~/.travis/travis-build/Gemfile
# RUN bundler binstubs travis

# RUN apt-get install -y rvm
# RUN echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc

# rvm
RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.3.3"

# RUN /bin/bash -l -c "rvm requirements"
# RUN /bin/bash -l -c "rvm install 2.6.5"

COPY src/* /autograder/
# Just to be safe...
RUN chmod -R +x /autograder/run_autograder

ENTRYPOINT [ "/bin/bash --login" ]
