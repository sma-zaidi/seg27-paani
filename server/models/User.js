const query = require('../database/db.query'); // simplifies database queries

User = {

    create: async (email, password, account_type) => { // returns the index of the newly inserted item
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.users (email, password, account_type)
                                  VALUES (?, ?, ?)`, [email, password, account_type]);
            return result.insertId;

        } catch (error) { throw new Error(error) }
    },

    destroy: async (userid) => {
        try {
            result = await query(`DELETE FROM \`seg27-paani\`.users WHERE id = ?`, [userid]);
        } catch {}
    },

    exists: async (email) => {
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.users WHERE email = ?`, [email]);
            return result.length ? true : false;

        } catch (error) { throw new Error(error) }
    },

    getByEmail: async (email) => {
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.users WHERE email = ?`, [email]);
            return result[0];

        } catch (error) { throw new Error(error) }
    }
}

module.exports = User

// yeet = async (email) => {
//     try {
//         result = await User.getPassword(email);
//         //console.log(result);
//     } catch (error) {
//         console.log(error);
//     }
// }

// console.log(yeet('email@email.coma'));