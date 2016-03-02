Content = require('./content.coffee')
utils = require('./utils.coffee')
log = utils.log
tag = utils.tag
listItem = utils.listItem
header = utils.header

class ContentManager
	constructor: (@elementId) ->
		@id = ContentManager.contentManagers.length
		@contentArray = new Array()
		@currentContent
		@initialized = false
		@timeoutId
		@created = new Date()
		ContentManager.contentManagers.push this

	add: (content) ->
		content.id = @id + "_" + @contentArray.length
		@contentArray.push content
		content.contentManager = this
		content.lastShown = @created
		return this

	getOverlayId: -> "cm_#{@id}_overlay"
	getOverlayElement: -> $("#" + @getOverlayId())
	getHtmlContentId: (content) -> "cm_#{content.contentManager.id}_content_#{content.id}"
	getCurrentElement: -> @getElement(@currentContent)
	getElement: (content) -> $("#" + @getHtmlContentId(content)) if content?

	findNextContent: ->
		content.refresh @getElement(content) for content in @contentArray
		contents = (content for content in @contentArray when content.hasContent and content.isVisible())
		if contents.length > 0
			contents.reduce (acc, cur) -> if (cur.priority > acc.priority) or (cur.priority is acc.priority and cur.lastShown < acc.lastShown) then cur else acc

	nextContent: ->
		nextContent = @findNextContent()
		unless not nextContent? and @currentContent is nextContent
			log "Next content: #{nextContent}"
			currentElem = @getCurrentElement()
			currentCont = @currentContent
			@currentContent = nextContent
			nextElem = @getCurrentElement()
			log "Showing #{@currentContent} which was previously show on #{@currentContent.lastShown}"
			nextContent.onPrepareToView(nextElem)
			if currentElem
				currentElem.fadeOut "slow", ->
					currentCont.onHide(currentElem)
					nextContent.lastShown = new Date()
					nextElem.fadeIn "slow", -> nextContent.onView(nextElem)
			else
				nextContent.lastShown = new Date()
				nextElem.fadeIn "slow", -> nextContent.onView(nextElem)

	start: ->
		unless @initialized
			@initialize $("#" + @elementId)
			@initialized = true
		@timeoutId = window.setTimeout (=> @changeContent()), 1000
		#@changeContent()

	initialize: (container) ->
		container.append tag("div", "", { id: @getOverlayId() , class: "overlay" })
		container.append tag("div", "", { id: @getHtmlContentId(content), class: "container" }) for content in @contentArray

		content.initialize @getElement(content) for content in @contentArray
		setInterval (-> $(".red_anime,.blue_anime,.grey_anime,.yellow_anime").animateHighlight("#000000",5000)), 6000
		@getOverlayElement().click( => @changeContent() )
		#@getOverlayElement().width(container.width())
		#@getOverlayElement().height(container.height())
		this

	changeContent: ->
		log "Changing content..."
		clearTimeout(@timeoutId);
		@nextContent()
		if @currentContent?.minimumShowTime?
			log "Going to change content in #{@currentContent.minimumShowTime} ms"
			@timeoutId = window.setTimeout (=> @changeContent()), @currentContent.minimumShowTime
		else if not @currentContent?
		  @timeoutId = window.setTimeout (=> @changeContent()), 1000
		return this

	shuffle: ->	
		@contentArray.shuffle()
		return this

ContentManager.contentManagers = []


module.exports = ContentManager