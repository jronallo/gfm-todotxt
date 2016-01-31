Plugin = require './plugin'
module.exports = ImdoneAtomHighlight =
  deactivate: ->
    @imdone.removePlugin Plugin if (@imdone && @imdone.removePlugin)

  consumeImdone: (@imdone) ->
    @imdone.addPlugin(Plugin) if (@imdone && @imdone.addPlugin)
