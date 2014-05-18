Spine             = require("spine")
$                 = Spine.$
Model             = Spine.Model
Extender          = require("plugins/model_extender")

class Session extends Spine.Model

  @extend Extender

  @configure "Session", 'user_id', 'access_token'

  @defaults:
    access_token: null,
    user_id: null
    
  @redirect: (url='', hash='') ->
    location.href = url + hash
    
  init: ->
    @load @session

  authenticated: ->
    ret = @access_token
    @log @
    @log ret
    Boolean(ret)

  # Saves session information to cookie
  save: (auth_hash) ->
    $.cookie('user_id', auth_hash.id)
    $.cookie('access_token', auth_hash.access_token)

  # Loads session information from cookie
  session: ->
    user_id: $.cookie('user_id')
    access_token: $.cookie('access_token')
    
      
module?.exports = Model.Session = Session

