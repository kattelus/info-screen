Content = require('./content.coffee')
utils = require('./utils.coffee')

class BambooContent extends Content 
  constructor: (@url, options) ->
    @filterFunction = (job) -> job.state is "Failed"
    super
    @hasContent = false

  handleOptions: (options) ->
    super
    return unless options?
    @filterFunction = options.filterFunction if options.filterFunction?

  initialize: (container) ->
    $.get @url + "/rest/api/latest/result.json?jsonp-callback=?", ((data) =>
      filteredJobs = (job for job in data.results.result when @filterFunction(job))
      if @header? then content = utils.header @header else ""
      (content = content + utils.listItem(job.plan.shortName, @resolveColor(job.lifeCycleState, job.state))) for job in filteredJobs
      container.html utils.tag("ul", content)
      @hasContent = filteredJobs.length > 0
      log "#{@} refreshed. #{filteredJobs.length} filtered jobs"
    ), "jsonp"

  resolveColor: (lifeCycleState, state) ->
    color = ""
    switch state
      when "Successful" then color = "blue"
      when "Failed" then color = "red"

    color = color + "_anime" if lifeCycleState is "Running"

    return color

  refresh: (container) -> @initialize container

module.exports = BambooContent