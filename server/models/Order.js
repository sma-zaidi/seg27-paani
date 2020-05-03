  
const query = require('../database/db.query'); // simplifies database queries

Order = {
    getOrderHistory: async (customerid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders WHERE customer_id = ?`, [customerid])
            return result;
        }catch (error) {throw new Error(error)}
    },

    getByCompanyAndStatus: async (companyid, status) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders
                                  INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id                     
                                  WHERE company_id = ? AND status = ?`, [companyid, status]);
            return result;
        } catch (error) { throw new Error(error) }
    },
}

module.exports = Order