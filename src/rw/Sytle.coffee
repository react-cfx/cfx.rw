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

  cssObj =
    reactcss:
      default:
        default: {}
    reactlook:
      default: {}

  for k, v of cssData

    unless(
      k is '::-webkit-input-placeholder' or
      k is '::-moz-placeholder' or
      k is '::input-placeholder'
    )

      continue if typeof v is ('object' or 'function')

      cssObj.reactcss.default.default[k] = v

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
