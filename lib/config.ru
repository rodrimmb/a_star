require "json"

Dir.glob('./{model,controllers,helpers,model/persistence}/*.rb').each { |file| require file }

map('/data') { run DataJson }
map('/') { run Web }
map('/searches') {run SearchesController}
map('/nodes') {run NodesController}
map('/solution') {run SolutionController}