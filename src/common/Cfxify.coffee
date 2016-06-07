{
  # createClass
  createElement
  # PropTypes
} = require 'react'
createComponent = require './Component'

cfxify = (e) ->
  (args...) -> createElement.apply @
  , [ e ].concat args

cfx = (component, wrapFunc) ->

  # if component.propTypes
  #   pt = component.propTypes PropTypes
  #   delete component.propTypes

  comp = createComponent.call @, component

  # comp.propTypes = pt if pt

  unless wrapFunc
  then cfxify comp
  else cfxify wrapFunc comp

module.exports = {
  cfxify
  cfx
}
