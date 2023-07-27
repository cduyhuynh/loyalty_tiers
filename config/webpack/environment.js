const { environment } = require('@rails/webpacker')

if (process.env.RAILS_ENV != 'production') environment.splitChunks()

module.exports = environment
