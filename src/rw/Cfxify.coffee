{
  cfxify
  cfx
} = require '../common/Cfxify'

Radium = require 'radium'
Look = require 'react-look'
{ StyleSheet } = Look
reactCSS = (
  require 'reactcss'
).default

ssct = StyleSheet.create
sscs = StyleSheet.combineStyles

RW =

  cfxify: (tag) -> (props, args...) ->

    if props.style

      # isArray
      if Array.isArray props.style

        for i, v of props.style

          {
            reactcss
            reactlook
          } = props.style[i]

          if reactcss or reactlook

            props.style[i] = reactCSS reactcss

            reactlook = ssct reactlook

            if props.className
              sscs.call props.className
              , reactlook
            else
              props.className = reactlook

            break

      else

        {
          reactcss
          reactlook
        } = props.style

        if reactcss or reactlook

          reactcss = (reactCSS reactcss).default
          reactlook = (ssct reactlook).default

          props = Object.assign {}
          , props
          , style: reactcss

          props = Object.assign {}
          , props
          , className:
            if props.className
            then(
              sscs.call {}
              , props.className
              , reactlook
            )
            else reactlook

    newArgs = [].concat [props], args

    tagFunc = cfxify tag
    tagFunc.apply @, newArgs

  cfx: (component) ->

    cfx.call @
    , component
    , [
      Radium
      Look.default
    ]

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
