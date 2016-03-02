$.fn.animateHighlight = (highlightColor, duration) ->
	highlightBg = highlightColor || "#FFFF9C";
	animateMs = duration || 1500;	
	return this.each ->
		originalBg = $(this).css("backgroundColor")
		$(this).animate({backgroundColor: highlightBg}, animateMs / 2).animate({backgroundColor: originalBg}, animateMs / 2)

# from coffeescript cookbook (not exactly correct way to do it...)
Array::shuffle = -> @sort -> 0.5 - Math.random()

log = (message) -> console.log message if console?
attributes = (attrs={}) -> (" #{key}=\"#{value}\"" for key, value of attrs).join("")
tag = (name, content="", attrs) -> "<#{name}#{attributes(attrs)}>#{content}</#{name}>"
listItem = (content="", cssClass="") -> tag "li", content, { class: cssClass }
header = (content="") -> listItem content, "header"
currentTime = -> new Date().valueOf()
secondsAgo = (date) => Math.floor((currentTime() - date.valueOf()) / 1000)
minsAgo = (date) => Math.floor(secondsAgo(date) / 60)
hoursAgo = (date) => Math.floor(minsAgo(date) / 60)
daysAgo = (date) => Math.floor(hoursAgo(date) / 24)
timeAgoAsText = (date) ->
	return "-#{daysAgo(date)}&nbsp;d" if daysAgo(date) > 0
	return "-#{hoursAgo(date)}&nbsp;h" if hoursAgo(date) > 0
	return "-#{minsAgo(date)}&nbsp;min" if minsAgo(date) > 0
	return "-#{secondsAgo(date)}&nbsp;s" if secondsAgo(date) > 0

module.exports =
	log: log
	attributes: attributes
	tag: tag
	listItem: listItem
	header: header
	currentTime: currentTime
	secondsAgo: secondsAgo
	minsAgo: minsAgo
	hoursAgo: hoursAgo
	daysAgo: daysAgo
	timeAgoAsText: timeAgoAsText

