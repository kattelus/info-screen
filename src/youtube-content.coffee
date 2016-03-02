Content = require('./content.coffee')
utils = require('./utils.coffee')

class YoutubeContent extends Content
  constructor: (@url, options) ->
    super
    @player
    @playerInitialized = false
    @hasContent = false
    @minimumShowTime = null # never expires

  getYtPlayerId: -> "ytplayer_" + @id
  
  getYtPlayerElement: -> $ "#" + @getYtPlayerId

  initialize: (container) ->
    container.html utils.tag("iframe", "", { id: @getYtPlayerId(), src: @url + "?showinfo=0&rel=0&controls=0&enablejsapi=1&iv_load_policy=3", scrolling: "no", frameborder: "0" })
    @player = new YT.Player(@getYtPlayerId())
    # waiting for moment to make sure player is ready
    setTimeout (=> @hasContent = true ), 2000
    
  onView: (container) ->
    @player.setPlaybackQuality "highres"
    @player.playVideo()
    unless @playerInitialized
      contentManager = @contentManager
      @player.addEventListener "onStateChange", (event) ->
        contentManager.changeContent() if event.data is YT.PlayerState.ENDED
      @playerInitialized = true

  onHide: (container) ->
    unless @player.getPlayerState() is YT.PlayerState.ENDED
      @player.stopVideo()
      #@player.seekTo(0)

module.exports = YoutubeContent