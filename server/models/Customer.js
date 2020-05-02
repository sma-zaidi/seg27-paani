const query = require('../database/db.query'); // simplifies database queries

Customer = {

    create: async (userid, name, contact_number, address, location) => { // returns the index of the newly inserted item
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.customers (id, name, contact_number, address, location)
                                  VALUES (?, ?, ?, ?, ?)`, [userid, name, contact_number, address, location]);
            return result.insertId;

        } catch (error) { throw new Error(error); }
    },

    getById: async (id) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.customers WHERE id = ?`, [id]);
            return result[0];

        } catch (error) { throw new Error(error) }
    }
}

module.exports = Customer

// yeet = async (id) => {
//     try {
//         result = await Customer.getById(id);
//         console.log(result);
//     } catch (error) {
//         console.log(error);
//     }
// }

// yeet(13)