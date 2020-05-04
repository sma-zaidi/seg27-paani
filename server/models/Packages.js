const query = require('../database/db.query'); // simplifies database queries

Package = {

    create: async (companyid, price_base, price_per_km) => {
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.packages (company_id, price_base, price_per_km)
                                  VALUES (?, ?, ?)`, [companyid, price_base, price_per_km]);
            return result.insertId;

        } catch (error) { throw new Error(error) }
    },

    getPackages: async (companyid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.packages WHERE company_id = ?`, [companyid])
            return result;
        }catch (error) {throw new Error(error)}
    },

}

module.exports = Package