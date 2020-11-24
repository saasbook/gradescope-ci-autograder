# Runs a `.travis.yml` file
# stuffs everything in STDOUT visiable to students.
require 'yaml'
require 'open3'
require 'json'

RESULTS = { output: '', stdout_visibility: 'visible' }
RESULTS_FILEPATH = 'results/results.json'

stdout, stderr, status = Open3.capture3("ls")

RESULTS[:output] << "STDOUT LS:\n\n#{stdout}\n#{'=' * 20}\n\n"
RESULTS[:output] << "STDERR LS:\n\n#{stderr}\n#{'=' * 20}\n\n"
RESULTS[:output] << "STATUS LS:\n\n#{status}\n#{'=' * 20}\n\n"

File.open(RESULTS_FILEPATH,"w") do |f|
  f.write(RESULTS.to_json)
end

class TravisConfigRunner
  TRAVIS_FILE_NAME = '.travis.yml'
  def init
    if self.config_file_present?
    else
    end
  end

  def run
  end

  def load_file
    @config = YAML.load_file(self.TRAVIS_FILE_NAME)
  end

  def set_default_rails_steps
    @config = {
      'install': [
        'bundle install',
        'yarn install',
      ],
      'script': [
        'export RAILS_ENV=test',
        'bundle exec rake db:setup',
        'bundle exec rspec spec/',
        'bundle exec cucumber'
      ]
    }
  end

  def exec_command(command)

  end

  def config_file_present?

  end

  def exec_travis_step(step)

  end

  # The "complete" list of travis steps.
  # https://docs.travis-ci.com/user/job-lifecycle/
  def travis_steps
    [
      # 'apt addons'
      # 'cache components'
      'before_install',
      'install',
      'before_script',
      'script',
      # 'before_cache', (if and only if caching is effective)
      # 'after_success', or after_failure
      # 'before_deploy', (if and only if deployment is active)
      # 'deploy',
      # 'after_deploy', (if and only if deployment is active)
      'after_script',
    ]
  end
end
