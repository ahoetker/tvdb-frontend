module.exports = {
  devServer: {
    proxy: {
      '^/function/*': {
        target: 'https://andrewhoetker.com',
        changeOrigin: true,
        secure: false
      }
    }
  }
};