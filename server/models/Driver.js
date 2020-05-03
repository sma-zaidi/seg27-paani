const query = require('../database/db.query'); // simplifies database queries

Driver = {

    exists: async(cnic) => {
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.drivers WHERE cnic = ?`, [cnic]);
            return result.length ? true : false;

        } catch (error) { throw new Error(error) }
    },

    add: async (company_id, name, cnic, contact_number) => {
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.drivers (company_id, name, cnic, contact_number)
                                  VALUES (?, ?, ?, ?)`, [company_id, name, cnic, contact_number]);
            
            return result.insertId;
        }catch (error) {throw new Error(error);}
    },

    getDrivers: async (companyid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.drivers WHERE company_id = ?`, [companyid]);
            return result;
        } catch (error) { throw new Error(error) }
    },

    update: async (id, name, cnic, contact_number) => {
        try {
            result = await query(`UPDATE \`seg27-paani\`.drivers
                                  SET
                                    name = ?,
                                    cnic = ?,
                                    contact_number = ?
                                  WHERE id = ?`, [name, cnic, contact_number, id]);
            return result;

        } catch (error) { throw new Error(error) }
    },
}

module.exports = Driver