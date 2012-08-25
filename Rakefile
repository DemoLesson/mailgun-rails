require 'rake'
require 'rake/gempackagetask'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |jewel|
    jewel.name        = 'mailgun-rails'
    jewel.summary     = 'Mailgun adapter for Rails.'
    jewel.email       = ['tanel.suurhans@perfectline.ee', 'tarmo.lehtpuu@perfectline.ee', 'kbecker@kellybecker.me']
    jewel.homepage    = 'https://github.com/perfectline/mailgun-rails'
    jewel.description = 'Mailgun adapter for Rails.'
    jewel.authors     = ["Tanel Suurhans", "Tarmo Lehtpuu", "Kelly Becker"]
    jewel.files       = FileList["lib/mailgun-rails.rb", "MIT-LICENCE", "README.markdown"]
    jewel.add_dependency 'curb'
    jewel.add_dependency 'activesupport'
    jewel.add_dependency 'actionmailer'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
