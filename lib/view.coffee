{View} = require 'space-pen'
{Emitter, Disposable, CompositeDisposable} = require 'atom'
PythonNosetestsListView = require './listview'
PythonNosetestsErrorView = require './errorview'

module.exports =
class PythonNosetestsView extends View



  @content: ->
    @div class: 'python-nosetests', =>
      @subview 'listview', new PythonNosetestsListView()
      @subview 'errorview', new PythonNosetestsErrorView()


  # onClickError: (error) =>
  #   alert(error.message)
  #   @errorview.load(error)


  initialize: ->
    @listview.setOnClickError (error) =>
      @errorview.load(error)


  constructor: (callbackErrorPane) ->
    super

    @emitter = new Emitter

    @callbackErrorPane = callbackErrorPane

  onDidChangeTitle: (callback) ->
    @emitter.on 'did-change-title', callback

  onDidChangeModified: (callback) ->
    # No op to suppress deprecation warning
    new Disposable

  getTitle: ->
    "Python Nosetests"

  getURI: ->
    'python-nosetests://listview/'

  getIconName: ->
    null

  getPath: ->
    'python-nosetests://listview/'

  getListView: ->
    return @listview

  getErrorView: ->
    return @errorview
