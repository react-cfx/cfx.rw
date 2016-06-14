{
  # createClass
  createElement
  # PropTypes
} = require 'react'
createComponent = require './Component'

cfxify = (e) ->
  (args...) -> createElement.apply @
  , [ e ].concat args

cfx = (component, wrapFuncs) ->

  # if component.propTypes
  #   pt = component.propTypes PropTypes
  #   delete component.propTypes

  comp = createComponent.call @, component

  # comp.propTypes = pt if pt

  if wrapFuncs
    for wrapFunc in wrapFuncs
      comp = wrapFunc comp

  cfxify comp

module.exports = {
  cfxify
  cfx
}
