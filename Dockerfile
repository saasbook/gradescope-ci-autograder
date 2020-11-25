FROM gradescope/auto-builds:latest


RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

RUN apt-add-repository -y ppa:rael-gc/rvm
RUN apt-get update
RUN apt-get install -y sqlite3 libsqlite3-dev nodejs build-essential patch zlib1g-dev liblzma-dev autoconf bison libssl-dev libyaml-dev libreadline6-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev


# RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby
# RUN /bin/bash -l -c "rvm requirements"
# RUN /bin/bash -l -c "rvm install 2.6.5"

COPY src/* /autograder/
# Just to be safe...
RUN chmod +x /autograder/run_autograder
