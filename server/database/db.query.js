pool = require('./db.connect');

module.exports = async (sql, params) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((error, connection) => {
            if(error) reject(error);
            else {
                connection.query(sql, params, (error, result) => {
                    if(error) reject(error);
                    else resolve(result);
                    connection.release();
                })
            }
        })
    })
}