echo = -> console.log arguments
{
  assign
  keys
} = Object
{ Component } = require 'react'

module.exports = (component) ->

  Lifecycle = [
    # http://www.tuicool.com/articles/nu6zInB
    # start
    'getDefaultProps'

    # mount
    'getInitialState'
    'componentWillMount'
    # 'render'
    'componentDidMount'

    # props changed # 'propTypes'
    'componentWillReceiveProps'

    # state changed
    'shouldComponentUpdate'
    'componentWillUpdate'
    # 'render'
    'componentDidUpdate'

    #  unmount
    'componentWillUnmount'
  ]

  componentObj = {}
  # beforeConstructor
  # constructor
  # afterConstructor
  # lifecycle
  # render

  if typeof component is 'function'

    componentObj.render = component

  else if typeof component is 'object'

    for k, v of component
      # constructor && render
      if k in [
        'render'
        'constructor'
        'className'
      ]
        componentObj[k] = v
        continue

      # Lifecycle
      if k in Lifecycle
        unless componentObj.lifecycle
          componentObj.lifecycle = {}
        componentObj.lifecycle[k] = v
        continue

      unless typeof v is 'function'

        unless componentObj.beforeConstructor
          componentObj.beforeConstructor = {}
        componentObj.beforeConstructor[k] = v
        continue

      else
        if k[0] is '_'

          unless componentObj.beforeConstructor
            componentObj.beforeConstructor = {}
          componentObj.beforeConstructor[k] = v
          continue

        else

          unless componentObj.afterConstructor
            componentObj.afterConstructor = {}
          componentObj.afterConstructor[k] = v
          continue

  # TODO throw error
  else return

  # echo componentObj
  # TODO throw error
  return unless componentObj.render

  class newComponent extends Component

    # callWithState = (Func, args) ->
    callWithState = (Func) ->
      unless @props.state
      then Func.call @, @props
      else Func.call @, @props, @props.state

    bindProps = (props) ->

      (keys props)  .forEach (
        (
          current
          index
          array
        ) ->
          value = props[current]
          @[current] =
            if typeof value is 'function'
            then ( ->
              args = Array.prototype.slice.call arguments
              if @props
                args.push @props
                args.push @props.state if @props.state
              value.apply @, args
            ).bind @
            else value
      ).bind @

    constructor: (props) ->
      super props

      if componentObj.beforeConstructor
        bindProps.call @
        , componentObj.beforeConstructor

      if componentObj.constructor
        callWithState.call @
        , componentObj.constructor

      if componentObj.lifecycle
        bindProps.call @
        , componentObj.lifecycle

      if componentObj.afterConstructor
        bindProps.call @
        , componentObj.afterConstructor

      @

    render: ->
      callWithState.call @
      , componentObj.render
