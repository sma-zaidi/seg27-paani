const query = require('../database/db.query'); // simplifies database queries

Package = {

    create: async (companyid, price_base, price_per_km, bowser_capacity) => {
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.packages (company_id, price_base, price_per_km, bowser_capacity)
                                  VALUES (?, ?, ?, ?)`, [companyid, price_base, price_per_km, bowser_capacity]);
            return result.insertId;

        } catch (error) { throw new Error(error) }
    },

    update: async (packageid, price_base, price_per_km, bowser_capacity) => {
        try {
            result = await query(`UPDATE \`seg27-paani\`.packages
                                  SET
                                    price_base = ?,
                                    price_per_km = ?,
                                    bowser_capacity = ?
                                  WHERE id = ?`, [price_base, price_per_km, bowser_capacity, packageid]);
            return result;

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