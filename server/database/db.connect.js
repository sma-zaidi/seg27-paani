// provides a connection to an mysql database

const mysql = require('mysql');
const config = require('./db.config');

pool = mysql.createPool(config);

module.exports = pool

