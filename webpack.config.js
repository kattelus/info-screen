var path = require("path");
var webpack = require("webpack");
module.exports = {
  cache: true,
  entry: {
    ContentManager: "./src/content-manager.coffee",
    IframeContent: "./src/iframe-content.coffee",
    FeedContent: "./src/feed-content.coffee",
    YoutubeContent: "./src/youtube-content.coffee",
    BambooContent: "./src/bamboo-content.coffee",
    JenkinsContent: "./src/jenkins-content.coffee",
    SmokeMonsterContent: "./src/smoke-monster-content.coffee",
    TwitterContent: "./src/smoke-monster-content.coffee",
    ImageContent: "./src/image-content.coffee"
  },
  output: {
    path: path.join(__dirname, "lib"),
    publicPath: "lib/",
    filename: "[name].js",
    chunkFilename: "[chunkhash].js",
    // export itself to a global var
    libraryTarget: "var",
    // name of the global var
    library: "[name]"

    //filename: "MyLibrary.[name].js",
    //library: ["MyLibrary", "[name]"],
  },
  externals: {
    // require("jquery") is external and available
    //  on the global var jQuery
    "jquery": "jQuery"
  },
  module: {
    loaders: [
      // required to write "require('./style.css')"
      //{ test: /\.css$/,    loader: "style-loader!css-loader" },
      
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
    ]
  },
  resolve: {
    alias: {
      // Bind version of jquery
      jquery: "jquery"
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      // Automtically detect jQuery and $ as free var in modules
      // and inject the jquery library
      // This is required by many jquery plugins
      jQuery: "jquery",
      $: "jquery"
    })
  ]
};