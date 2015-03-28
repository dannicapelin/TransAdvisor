require 'open-uri'
require 'yaml'

URL = 'http://stash.lpil.uk/gp_data.yml'

insts = YAML.load open(URL).read

insts.each do |inst|
  puts inst['name']
  Institution.new(inst).save
end

puts 'Done.'
