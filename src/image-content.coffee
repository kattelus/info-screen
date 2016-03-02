Content = require('./content.coffee')
utils = require('./utils.coffee')

class ImageContent extends Content
  constructor: (@url, options) ->
    super
    @initialized = false

  getImageId: -> "cm_#{@contentManager.id}_img_#{@id}"

  # we assume that image is static and no reason to reload after initialization
  initialize: (container) -> container.html utils.tag("img", "", { src: @url, id: @getImageId() })

  onView: (container) ->
    unless @initialized
      utils.log "Scaling image"
      imageAspectRatio = $("#" + @getImageId()).width() / $("#" + @getImageId()).height()
      containerAspectRatio = container.width() / container.height()
      if imageAspectRatio > containerAspectRatio
        $("#" + @getImageId()).width(container.width())
      else 
        $("#" + @getImageId()).height(container.height())
      $("#" + @getImageId()).css("opacity", 100)
      @initialized = true

module.exports = ImageContent