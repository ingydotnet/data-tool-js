class global.DataTool
  version: '0.0.1'

_ = require 'lodash'
_.extend global,
  say: console.log
  warn: console.warn
  dir: console.dir
