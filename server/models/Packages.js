const query = require('../database/db.query'); // simplifies database queries

Package = {
    getPackages: async (companyid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.packages WHERE company_id = ?`, [companyid])
            return result;
        }catch (error) {throw new Error(error)}
    },
}

module.exports = Package