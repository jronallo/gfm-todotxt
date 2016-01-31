ImdoneAtomHighlight = require './imdone-atom-highlight'
{$, $$, $$$} = require 'atom-space-pen-views'
{Emitter} = require 'atom'
_ = require 'lodash'
moment = require 'moment'

module.exports =
class Plugin extends Emitter
  @pluginName: require('../package.json').name
  ready: false
  constructor: (@repo, @imdoneView) ->
    super()

    #todo:30 Maybe there's a way to highlight_dates on imdoneView initialization?
    @imdoneView.on 'board.update', =>
      @highlight_dates()

  highlight_dates: ->
    board = @imdoneView.imdoneView.board
    due_tasks = board.find('td:contains(due)').next()
    for task in due_tasks
      task_date = $(task).text()
      day = moment(task_date)
      now = moment(new Date())
      diff = moment.duration(day.diff(now))
      hours_diff = diff.asHours()
      if hours_diff < 0
        $(task).addClass('task-overdue')
      else if hours_diff < 48
        $(task).addClass('task-due')
      else if hours_diff < 120
        $(task).addClass('task-coming-due')

  # Interface --------------------------------------------------------------
  isReady: ->
    @ready
  getView: ->
    @view
