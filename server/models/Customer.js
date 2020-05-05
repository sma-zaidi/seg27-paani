const query = require('../database/db.query'); // simplifies database queries

Customer = {

    create: async (userid, name, contact_number, address, location) => { // returns the index of the newly inserted item
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.customers (id, name, contact_number, address, location)
                                  VALUES (?, ?, ?, ?, ?)`, [userid, name, contact_number, address, location]);
            return result.insertId;

        } catch (error) { throw new Error(error); }
    },

    getById: async (customerid) => { // returns JSON with a row from the customers table in the database.
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.customers WHERE id = ?`, [customerid]);
            return result[0];

        } catch (error) { throw new Error(error) }
    },

    editDetails: async (id, name, contact_number, address, location) => {
        try {
            result = await query(`UPDATE \`seg27-paani\`.companies
                                  SET
                                    name = ?,
                                    contact_number = ?,
                                    address = ?,
                                    location=?
                                  WHERE id = ?`, [name, contact_number,address, location, id]);
                                  
            return result;

        } catch (error) { throw new Error(error) }
    },

}

module.exports = Customer