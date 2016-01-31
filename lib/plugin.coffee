#new:0 0 due:2016-01-01
#todo:0 1 due:2016-02-03
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

    @imdoneView.on 'board.update', =>
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
