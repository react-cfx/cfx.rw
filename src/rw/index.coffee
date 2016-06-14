{
  PropTypes
  createFactory
} = RW = require 'react'
{
  cfxify
  cfx
} = require './Cfxify'

{
  Presets
  LookRoot
  StyleSheet
} = require 'react-look'
Style = require './Sytle'

createComponent = require '../common/Component'
classnames = require './classnames'

Comps = require './Components'

{
  Provider
  connect
} = require '../common/Redux'

module.exports = {
  RW

  cfxify
  cfx

  # Style
  Styl: StyleSheet.create
  c: StyleSheet.combineStyles
  classnames

  Presets
  LookRoot

  Comps

  Provider
  connect

  PropTypes

  createFactory
  createComponent
}
