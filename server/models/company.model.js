const query = require('../database/db.query'); // simplifies database queries

model = {
    
    create: async (company) => { // executes a query to add user to database. 
        return await query(`INSERT INTO paani.company set ?`, [company]);
    },

    getAll: async () => {
        return await query(`SELECT * FROM paani.company`);
    },

    getByName: async (company_name) => {
        return await query(`SELECT * paani.company user WHERE name = ?`, [company_name]);
    },

}
    // more user methods will go here, e.g userExists(), deleteUser() etc

module.exports = model