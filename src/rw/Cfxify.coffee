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

# styleLogger = (
#   {
#     componentName
#     style
#   }
# ) ->
#   console.log 'Name: ' + componentName
#   , style

checkProps = (
  {
    componentName
    style
  }
) ->
  _style = Object.assign {}, style
  # TODO 多属性合并的问题，后面不能这么简单处理，需要使用 plugin 机制 将 属性 展开，再合并
  delete _style.border if style.border
  Radium.Plugins.checkProps {
    componentName
    style: _style
  }
  {
    componentName
    style
  }

ConfiguredRadium = (component) ->
  (
    Radium
      plugins: [
        Radium.Plugins.mergeStyleArray
        checkProps
        Radium.Plugins.resolveMediaQueries
        Radium.Plugins.resolveInteractionStyles
        Radium.Plugins.keyframes
        Radium.Plugins.visited
        # Radium.Plugins.removeNestedStyles
        Radium.Plugins.prefix
        # styleLogger
        checkProps
      ]
  ) component

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

          continue unless style

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
      ConfiguredRadium
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
