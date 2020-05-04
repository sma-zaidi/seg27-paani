  
const query = require('../database/db.query'); // simplifies database queries

Order = {
    getOrderHistory: async (customerid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders WHERE customer_id = ?`, [customerid])
            return result;
        }catch (error) {throw new Error(error)}
    },
}

module.exports = Order