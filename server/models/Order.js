  
const query = require('../database/db.query'); // simplifies database queries

Order = {

	getOrderHistory: async (customerid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders WHERE customer_id = ?`, [customerid])
            return result;
        }catch (error) {throw new Error(error)}
    },


    getlatestOrder: async (customerid) => {
        try {
        	
            result = await query(`SELECT DISTINCT name, status, bowser_capacity, delivery_time, cost FROM \`seg27-paani\`.orders 
        		    				INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
       			    				INNER JOIN \`seg27-paani\`.companies ON \`seg27-paani\`.packages.company_id = \`seg27-paani\`.companies.id
            						WHERE customer_id = ?`, [customerid]);        
            
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

    getCompanyHistory: async (companyid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders
                                  INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
                                  WHERE company_id = ?`, [companyid]);
            return result;
        } catch (error) {throw new Error(error)}
    },

    updateStatus: async (orderid, status) => {
        try {
            result = await query(`UPDATE \`seg27-paani\`.orders
                                  SET status = ?
                                  WHERE id = ?`, [status, orderid]);
            return result;

        } catch (error) { throw new Error(error) }
    },


}

module.exports = Order