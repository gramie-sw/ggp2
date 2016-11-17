module.exports = {

  // bable-polyfill for Promise support
  // whatwg-fetch for fetch support
  entry: ['babel-polyfill', 'whatwg-fetch', './frontend/main.js'],
  output: {
    path: './app/assets/javascripts/react',
    filename: 'react.bundle.js'
  },

  module: {
    loaders: [
      {
        test: /.js?$/,
        loader: 'babel-loader',
        include: /frontend/,
        query: {
          presets: ['es2015', 'stage-1', 'react'],
          plugins: ['transform-decorators-legacy']
        }
      }
    ]
  },

  devServer: {
    contentBase: 'build/',
    inline: true
  },

  watch: true
};