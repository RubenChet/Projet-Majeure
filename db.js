const mongoose = require('mongoose');

function connectToDatabase() {
  const dbUrl = `mongodb://${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`;
  return mongoose.connect(dbUrl, { useNewUrlParser: true, useUnifiedTopology: true });
}

module.exports = connectToDatabase;
