# Runs a `.travis.yml` file
# stuffs everything in STDOUT visiable to students.
require 'yaml'
require 'open3'
require 'json'

puts "ARGS #{ARGV}"
RESULTS = {
  output: '<h2>CI Results</h2>',
  stdout_visibility: 'visible',
  score: 0,
  tests: [
    score: 0,
    name: "There are actual tests here...",
    output: "Please use the standard output section"
  ]
}

RESULTS_FILEPATH = ARGV[1]

def simple_details(summary, code)
  <<~HTML
    <details>
      <summary>#{summary}</summary>
      <pre>#{code}</pre>
    </details>
  HTML
end

def format_output(index, cmd, stdout, stderr, status_code)
  <<~HTML
    <details>
      <summary><h3>#{index}: <code>#{cmd}</code></h3></summary>
      #{simple_details('Standard Output', stdout) if stdout}
      #{simple_details('Standard Error', stderr) if stderr}
      <strong>The command #{cmd} exited with status: #{status_code}</strong>
    </details>
  HTML
end

standard_steps = [
  'export RAILS_ENV=test',
  'rm -rf .bundle/ vendor/bundle/',
  'bundle config set without production && bundle install',
  'yarn install --ignore platform --ignore engines',
  'bundle exec rake db:setup',
  'bundle exec rspec spec/',
  'bundle exec cucumber'
].each_with_index do |cmd, index|
  begin
    stdout, stderr, status_code = Open3.capture3("/bin/bash -l -c \"#{cmd}\"", chdir: ARGV[0])
  rescue err
    RESULTS[:output] << simple_details("An Error Occured: #{cmd}", err)
  end
  RESULTS[:output] << format_output(index, cmd, stdout, stderr, status_code)
end


File.open(RESULTS_FILEPATH,"w") do |f|
  f.write(RESULTS.to_json)
end

class TravisConfigRunner
  TRAVIS_FILE_NAME = '.travis.yml'
  def init
    if self.config_file_present?
      load_file
    else
      set_default_rails_steps
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
    false
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
