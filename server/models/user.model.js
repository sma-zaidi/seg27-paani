const query = require('../database/db.query'); // simplifies database queries

model = {
    
    create: async (user) => { // executes a query to add user to database. 
        return await query(`INSERT INTO user set ?`, [user]);
    },

    getAll: async () => {
        return await query(`SELECT * FROM user`);
    },

    getByEmail: async (email_address) => {
        return await query(`SELECT * FROM user WHERE email_address = ?`, [email_address]);
    }

}
    // more user methods will go here, e.g userExists(), deleteUser() etc

module.exports = model