# bash -c 'BASH_ENV=/etc/profile exec bash'
# /bin/bash --login

echo "Pre Install Script"
/bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.6.5 && rvm use 2.6.5"
/bin/bash -l -c "ruby -v"

ruby -v

# Install travis build tool to compile yaml files.
git clone https://github.com/travis-ci/travis-build
cd travis-build
mkdir -p ~/.travis
# ln -s $PWD ~/.travis/travis-build
