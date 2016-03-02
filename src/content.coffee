class Content 
  constructor: (@url, options) ->
    @id
    @lastShown
    @hasContent = true
    @priority = 1
    @contentManager
    @minimumShowTime = 1000 * 10
    @handleOptions options
    @header

  handleOptions: (options) ->
    return unless options?
    @priority = options.priority if options.priority?
    @minimumShowTime = options.minimumShowTime if options.minimumShowTime?
    @header = options.header if options.header?
    @isVisible = options.visibilityFunction if options.visibilityFunction?

  # called once on initilization
  initialize: (container) -> 
  # called before deciding which content to show next
  refresh: (container) ->
  # called just before viewing this content
  onPrepareToView: (container) ->
  # called just after this content has viewed
  onView: (container) ->
  # called just after this content has hidden
  onHide: (container) ->
  # called before deciding which content to show
  isVisible: (container) -> true
  toString: -> @constructor.name + " url: " + @url

module.exports = Content