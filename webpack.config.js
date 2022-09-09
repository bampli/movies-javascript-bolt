'use strict';

const Webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const buildDirectory = path.join(__dirname, 'build');

module.exports = {
  mode: 'development',
  entry: {
    app: './src/app.ts'
  },
  output: {
    filename: 'app.js',
    path: buildDirectory,
  },
  devtool: false,
  devServer: {
    static: buildDirectory,
    port: process.env.PORT || 8080
  },

  stats: {
    colors: true,
    reasons: true
  },

  plugins: [
    new HtmlWebpackPlugin({template: 'src/assets/index.html'}),
    // new Webpack.EnvironmentPlugin({
    //   'NEO4J_URI': 'bolt+s://d8074969b9e77ba9985b14aaa44dd925.neo4jsandbox.com:7687',
    //   'NEO4J_DATABASE': 'movies',
    //   'NEO4J_USER': 'neo4j',
    //   'NEO4J_PASSWORD': 'act-counts-sequences',
    //   'NEO4J_VERSION': ''
    // })
    new Webpack.EnvironmentPlugin({
      'NEO4J_URI': 'neo4j+s://demo.neo4jlabs.com',
      'NEO4J_DATABASE': 'movies',
      'NEO4J_USER': 'movies',
      'NEO4J_PASSWORD': 'movies',
      'NEO4J_VERSION': ''
    })
  ],

  resolve: {
    extensions: ['.webpack.js', '.web.js', '.js', '.jsx']
  },

  module: {
    rules: [
      {
        test: /\.css$/i,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(png|svg|ico|jpe?g|gif)$/i,
        use: [
          {
            loader: 'file-loader',
          },
        ],
      },
    ]
  },
};

