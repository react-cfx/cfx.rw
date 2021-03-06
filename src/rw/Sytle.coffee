{ cfxify } = require './Cfxify'

classnames = require 'classnames'

# CSSModules = require 'react-css-modules'
Radium = require 'radium'
# Style = cfxify Radium.Style

Look = require 'react-look'

reactCSS = (
  require 'reactcss'
).default

{
  Presets
  LookRoot
  StyleSheet
} = Look
c = StyleSheet.combineStyles

Styl = (cssData) ->

  return unless cssData

  cssObj =
    reactcss:
      default:
        default: {}
    reactlook:
      default: {}

  for k, v of cssData

    unless(
      k is 'inputPlaceholder' or
      k is 'before' or
      k is 'after'
    )

      if(
        k is 'hover'
      )
        cssObj.reactcss.default.default[":#{k}"] = v

      else

        cssObj.reactcss.default.default[k] = v

    else

      if k is 'inputPlaceholder'
        cssObj.reactlook.default['::-webkit-input-placeholder'] =
        cssObj.reactlook.default['::-moz-placeholder'] =
        cssObj.reactlook.default['::input-placeholder'] = v

      else if(
        k is 'before' or
        k is 'after'
      )

        if v.content and not /^url/.test v.content
          v.content = "\'#{v.content}\'"

        cssObj.reactlook.default["::#{k}"] = v

      else
        cssObj.reactlook.default[k] = v

  cssObj

Styl.Presets = Presets
Styl.LookRoot = cfxify LookRoot

Styl.StyleSheet = StyleSheet
Styl.c = c

Styl.classnames = classnames

Styl.Radium = Radium
Styl.Look = Look
Styl.reactCSS = reactCSS

module.exports = Styl
