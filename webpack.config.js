var webpack = require('webpack');

var minify = process.env.MINIFY || false;
var uglify = minify ? [new webpack.optimize.UglifyJsPlugin()] : [];

module.exports = {
  entry: './build/dist/stampit.js',
  output: {
    path: __dirname,
    filename: minify ? 'stampit.min.js' : 'stampit.js',
    libraryTarget: 'umd',
    library: 'stampit'
  },
  plugins: [].concat(uglify)
};
