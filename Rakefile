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

file 'lib/Examples.txt' => ['lib/Examples.rb', 'lib/PrettyComment.rb'] do
  `ruby lib/Examples.rb > lib/Examples.txt`
end

task :examples => 'lib/Examples.txt'

task :default => :install
