Content = require('./content.coffee')
utils = require('./utils.coffee')

class SmokeMonsterContent extends Content 
  constructor: (@url, options) ->
    @filterFunction = (result) -> result.status is "ERROR"
    super
    @hasContent = false

  handleOptions: (options) ->
    super
    return unless options?
    @filterFunction = options.filterFunction if options.filterFunction?

  initialize: (container) ->
    $.get @url, ((data) =>
      filtered = (result for result in data when @filterFunction(result))
      if @header? then content = utils.header @header else ""
      #(content = content + utils.listItem(result.smokeTestCode, "red")) for result in filtered
      for entry in filtered
        content = content + utils.listItem(tag("span", "#{entry.failureCount}", { class: "sideitem" }) + utils.tag("span", entry.smokeTestName), "red")
      container.html utils.tag("ul", content)
      @hasContent = filtered.length > 0
      log "#{@} refreshed. #{filtered.length} filtered smoke test results"
    ), "jsonp"

  refresh: (container) -> @initialize container

module.exports = SmokeMonsterContent