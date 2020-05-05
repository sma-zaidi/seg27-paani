  
const query = require('../database/db.query'); // simplifies database queries

Order = {
    
    exists: async(customerid) => {
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.orders WHERE customer_id = ?`, [customerid]);
            return result.length ? true : false;

        } catch (error) { throw new Error(error) }
    },

    PlaceOrder: async (customerid, package_id, delivery_address, delivery_location,delivery_time, status,cost) => {//returns order id
        try {console.log("IN")
            result = await query(`INSERT INTO \`seg27-paani\`.orders (customer_id,package_id,delivery_address,delivery_location,delivery_time,status,cost)
                                  VALUES (?, ?, ?, ?, ?, ?, ?)`, [customerid, package_id, delivery_address, delivery_location,datetime, status,cost]);
            return result.insertId;
        }catch (error) {throw new Error(error)}
    },

	getOrderHistory: async (customerid) => {
        try {
            result = await query(`SELECT * FROM \`seg27-paani\`.orders 
                                    INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
                                    INNER JOIN \`seg27-paani\`.companies ON \`seg27-paani\`.packages.company_id = \`seg27-paani\`.companies.id
                                    WHERE customer_id = ?`, [customerid]);
            return result;
        }catch (error) {throw new Error(error)}
    },


    getlatestOrder: async (customerid) => {
        try {
            
            result = await query(`SELECT status FROM \`seg27-paani\`.orders 
                                    INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
                                    INNER JOIN \`seg27-paani\`.companies ON \`seg27-paani\`.packages.company_id = \`seg27-paani\`.companies.id
                                    WHERE last_update = (SELECT MAX(last_update) FROM \`seg27-paani\`.orders WHERE customer_id = ?)`, [customerid]);   
            if(result.length === 0){return false;}                              
            else{return result;}
        }catch (error) {throw new Error(error)}
    },

    ongoing: async(customerid) => {
        try {

            result = await Order.getlatestOrder(customerid);
            console.log(result[0].status);
            if(result[0].status != "complete"){console.log("finally");return true;}
            else{return false;}

        } catch (error) { throw new Error(error) }
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