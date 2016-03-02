Content = require('./content.coffee')
utils = require('./utils.coffee')

class IframeContent extends Content
  # refreshing frame alway just before show
  onPrepareToView: (container) -> container.html utils.tag("iframe", "", { src: @url, scrolling: "no", frameborder: "0" } )

module.exports = IframeContent