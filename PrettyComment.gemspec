Gem::Specification.new do |s|
  s.name        = 'PrettyComment'
  s.version     = '0.1.0'
  s.date        = Time.new.to_s[0,10]
  s.summary     = "Nice formatting of comments."
  s.description = "PrettyComment allows for nice formatting of status messages and comments for terminal output."
  s.authors     = ["Wolfgang Steiner"]
  s.email       = 'wolfgang.steiner@gmail.com'
  s.files       = ["lib/PrettyComment.rb"]
  s.homepage    = 'http://rubygems.org/gems/PrettyComment'
  s.add_dependency('ruby-terminfo', '>= 0.1.1')
end