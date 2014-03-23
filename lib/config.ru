require "json"

Dir.glob('./{model,controllers,helpers}/*.rb').each { |file| require file }

map('/data') { run DataJson }
map('/') { run Web }