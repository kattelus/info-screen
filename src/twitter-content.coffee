Content = require('./content.coffee')
utils = require('./utils.coffee')

class TwitterContent extends Content
  constructor: (query, options) ->
    super("http://search.twitter.com/search.json?q=#{query}", options)
    @hasContent = false

  initialize: (container) ->
    $.get @url + "&callback=?", ((data) =>
      if @header? then content = utils.header @header else ""
      (content = content + utils.listItem(tag("img", "", { src: tweet.profile_image_url, class: "sideitem" }) + tag("span", tweet.text))) for tweet in data.results
      container.html utils.tag("ul", content)
      @hasContent = data.results.length > 0
      log "#{@} refreshed. #{data.results.length} tweets"
    ), "jsonp"
  
  refresh: (container) -> @initialize container

module.exports = TwitterContent