# bash -c 'BASH_ENV=/etc/profile exec bash'
# /bin/bash --login

echo "Pre Install Script"
/bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.6.5 && rvm use 2.6.5"

# rvm use 2.6.5

# rbenv install 2.6.5
