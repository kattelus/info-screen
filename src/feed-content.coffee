Content = require('./content.coffee')
utils = require('./utils.coffee')

google.load("feeds", "1")

class FeedContent extends Content
  constructor: (@url, options) ->
    @maxAge = 30
    super
    @hasContent = false

  handleOptions: (options) ->
    super
    return unless options?
    @maxAge = options.maxAge if options.maxAge?

  initialize: (container) ->
    feed = new google.feeds.Feed(@url)
    feed.load (result) =>
      unless result.error
        if @header? then content = utils.header @header else ""
        minMinutesAgo = 9999
        @hasContent = false
        for entry in result.feed.entries
          entryTime = new Date(entry.publishedDate)
          minutesAgo = utils.minsAgo(entryTime)
          minMinutesAgo = minutesAgo if minutesAgo < minMinutesAgo
          content = content + utils.listItem(utils.tag("span", utils.timeAgoAsText(entryTime), { class: "sideitem" }) + utils.tag("span", entry.title))

        content = utils.tag("ul", content)
        container.html content
        @hasContent = minMinutesAgo < @maxAge
        utils.log "#{@} refreshed. Last entry #{minMinutesAgo} minutes ago"

  refresh: (container) -> @initialize container

module.exports = FeedContent