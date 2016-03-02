Content = require('./content.coffee')
utils = require('./utils.coffee')

class JenkinsContent extends Content 
  constructor: (@url, options) ->
    @filterFunction = (job) -> job.color is "red"
    super
    @hasContent = false

  handleOptions: (options) ->
    super
    return unless options?
    @filterFunction = options.filterFunction if options.filterFunction?

  initialize: (container) ->
    $.get @url + "/api/json?jsonp=?", ((data) =>
      filteredJobs = (job for job in data.jobs when @filterFunction(job))
      if @header? then content = utils.header @header else ""
      (content = content + utils.listItem(job.name, job.color)) for job in filteredJobs
      container.html utils.tag("ul", content)
      @hasContent = filteredJobs.length > 0
      log "#{@} refreshed. #{filteredJobs.length} filtered jobs"
    ), "jsonp"

  refresh: (container) -> @initialize container

module.exports = JenkinsContent