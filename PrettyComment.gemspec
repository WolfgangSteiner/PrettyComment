require './lib/version.rb'

Gem::Specification.new do |s|
  s.name        = 'PrettyComment'
  s.version     = PrettyComment::VERSION
  s.date        = Time.new.to_s[0,10]
  s.summary     = "Nice formatting of comments."
  s.description = "Formatting of status messages and comments for terminal output."
  s.authors     = ["Wolfgang Steiner"]
  s.email       = 'wolfgang.steiner@gmail.com'
  s.files       = ["lib/PrettyComment.rb"]
  s.homepage    = 'https://github.com/WolfgangSteiner/PrettyComment'
  s.add_dependency('ruby-terminfo', '>= 0.1.1')
end