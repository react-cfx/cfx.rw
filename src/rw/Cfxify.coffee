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

        styleArray = []
        classNames =
          if props.className
          then [ props.className ]
          else []

        for index, style of props.style

          {
            reactcss
            reactlook
          } = style

          if reactcss or reactlook

            reactcss = (reactCSS reactcss).default
            reactlook = (ssct reactlook).default

            styleArray.push reactcss if reactcss
            classNames.push reactlook if reactlook

          else

            styleArray.push style

        unless styleArray.length is 0
          props.style = styleArray

        unless classNames.length is 0
          props.className = sscs.apply {}
          , classNames

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
