require '../data-tool'
class global.DataTool.Command
  run: (args)->
    dir args
    warn 'Hi'

###
argparse = require 'argparse'

ArgumentParser = argparse.ArgumentParser
parser = new ArgumentParser
  prog: 'jyj'
  usage: 'jyj [<options>] [<input-file>]'
  version: "jyj - version #{version}"
  addHelp: true
  description: 'JSON <-> YAML Converter.'
  epilog: 'If called without options, `jyj` will read from stdin. ' +
    'The type of input will be autodetected.'
parser.addArgument \
  [ '-c', '--compact' ],
  action: 'storeTrue'
  help: "Write JSON output in a compact style."
parser.addArgument \
  'input-file',
  nargs: '?'
  help: "The (YAML/JSON) input data file."
args = parser.parseArgs()

file = args['input-file']
file ?= '/dev/stdin'
input = fs.readFileSync(file).toString()

if file.match /\.ya?ml$/i
  type = 'yaml'
else if file.match /\.json/i
  type = 'json'
else if input.match /^\s*[\{\[]/
  type = 'json'
else
  type = 'yaml'

if type == 'json'
  data = JSON.parse input
  output = YAML.dump data
else
  data = YAML.load input
  if args.compact
    output = JSON.stringify data
  else
    output = JSON.stringify data, null, 2
    output += '\n'

process.stdout.write output
###
