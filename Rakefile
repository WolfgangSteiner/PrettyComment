require_relative 'lib/version.rb'

task :build do
  `gem build PrettyComment.gemspec`
end

task :install => :build do
  `sudo gem install PrettyComment-#{PrettyComment::VERSION}.gem`
end

task :push => :build do
  `gem push PrettyComment-#{PrettyComment::VERSION}.gem`
end

task :default => :install
