{
  cfxify
  cfx
} = require '../common/Cfxify'

Radium = require 'radium'
# CSSModules = require 'react-css-modules'

RW = {
  cfxify
  cfx: (component) ->
    cfx.call @, component, Radium
}

module.exports = RW

# # CSS MODULES
# ###############
# args = Array.prototype.slice.call arguments
# if args.length is 2
#   styles = args.shift()
#   cfxify(
#     CSSModules(
#       (
#         Radium createClass.apply @
#         , args
#       )
#       , styles
#     )
#   )
# else
