const query = require('../database/db.query'); // simplifies database queries

model = {
    
    create: async (order) => { // executes a query to add user to database.
        console.log(order);
        return await query(`INSERT INTO paani.order (customer_id, package_id, order_status) VALUES (?, ?, ?)`, [order.customer_id, order.package_id, order.order_status]);
    },

    getAll: async () => {
        return await query(
            `SELECT * FROM paani.order 
            INNER JOIN paani.package ON paani.order.package_id = paani.package.package_id
            INNER JOIN paani.company ON paani.package.comp_id = paani.company.company_id`
        );
    },

    getAllByCompanyID: async (company_id) => {
        return await query(
            `SELECT * FROM paani.order 
            INNER JOIN paani.package ON paani.order.package_id = paani.package.package_id
            INNER JOIN paani.company ON paani.package.comp_id = paani.company.company_id
            WHERE comp_id = ?`,
            [company_id]
        );
    },
}

module.exports = model