Spine     = require("spine")
$         = Spine.$
Model     = Spine.Model
Photo     = require("models/photo")
User      = require("models/user")
Extender  = require("plugins/model_extender")

require('spine/lib/local')

class Recent extends Spine.Model

  @extend Extender
  
  @configure 'Recent', 'id'
  
  @extend Model.Local
  
  @logout: ->
    @destroyAll()
    @redirect 'logout'
  
  @redirect: (url) ->
    location.href = base_url + url
    
  init: (instance) ->
    return unless instance
    
  @loadRecent: (max = 100, callback) ->
    $.ajax
      contentType: 'application/json'
      dataType: 'json'
      processData: false
      headers: {'X-Requested-With': 'XMLHttpRequest', 'X-PING': 'pingpong'}
      url: "http://gap.webpremiere.dev" + base_url + 'photos/recent/' + max
      type: 'GET'
      success: callback
      error: @proxy @error
  
  @success: (json) ->
    @log json

  @error: (xhr) ->
    @log xhr
#    @logout()
      
module?.exports = Model.Recent = Recent