const query = require('../database/db.query'); //simplifies database queries

model = {
    
    create: async (customer) => {// query to add a new customer to the database
        return await query(`INSERT INTO paani.customer (name, contact_num, address, location ) VALUES (?,?,?,?)`, [customer.name, customer.contact_num, customer.address, customer.location ]);
    }, 
	
	getAll: async () => {
		return await query(
			`SELECT * FROM paani.customer`
		);
	},
}

module.exports = model
