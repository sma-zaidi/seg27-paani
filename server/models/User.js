const query = require('../database/db.query'); // simplifies database queries

User = { 

    create: async (email, password, account_type) => { // returns the id of the newly inserted item
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.users (email, password, account_type)
                                  VALUES (?, ?, ?)`, [email, password, account_type]);
            return result.insertId;

        } catch (error) { throw new Error(error) }
    },

    destroy: async (userid) => { // delete by id
        try {
            result = await query(`DELETE FROM \`seg27-paani\`.users WHERE id = ?`, [userid]);
        } catch (error) { console.log(error) } // this method is only called while handling an exception during User.create. Throwing an error
                                               // here MIGHT cause issues.
    },

    exists: async (email) => { // true if a user with this email exists, false otherwise
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.users WHERE email = ?`, [email]);
            return result.length ? true : false;

        } catch (error) { throw new Error(error) }
    },

    getByEmail: async (email) => { // returns userid, email, password and account_type
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.users WHERE email = ?`, [email]);
            return result[0];

        } catch (error) { throw new Error(error) }
    }
}

module.exports = User // don't forget this