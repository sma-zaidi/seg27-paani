const query = require('../database/db.query'); // simplifies database queries

Company = {

    create: async (userid, name, ntn, contact_number, address, location) => { // returns the index of the newly inserted item
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.companies (id, name, ntn, contact_number, address, location)
                                  VALUES (?, ?, ?, ?, ?, ?)`, [userid, name, ntn, contact_number, address, location]);
            return result.insertId;

        } catch (error) { throw new Error(error); }
    },

    getById: async (id) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.companies WHERE id = ?`, [id]);
            return result[0];

        } catch (error) { throw new Error(error) }
    }
}

module.exports = Company