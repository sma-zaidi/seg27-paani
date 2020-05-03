  
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
        	//Returns all the details for the order history page - customer side
            result = await query(`SELECT DISTINCT name, status, bowser_capacity, delivery_time, cost FROM \`seg27-paani\`.orders 
        		    				INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
       			    				INNER JOIN \`seg27-paani\`.companies ON \`seg27-paani\`.packages.company_id = \`seg27-paani\`.companies.id
            						WHERE customer_id = ?`, [customerid]);        
            
            return result;
        }catch (error) {throw new Error(error)}
    },

    
}

module.exports = Order