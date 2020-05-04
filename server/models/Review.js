const query = require('../database/db.query'); // simplifies database queries

Review = {

    exists: async(id) => {
        try {

            result = await query(`SELECT * FROM \`seg27-paani\`.reviews WHERE id = ?`, [id]);
            return result.length ? true : false;

        } catch (error) { throw new Error(error) }
    },	

    create: async (id, review, rating) => { // returns the index of the newly inserted review
        try {
            result = await query(`INSERT INTO \`seg27-paani\`.reviews (id, review, rating)
                                  VALUES (?, ?, ?)`, [id, review, rating]);
            return result.insertId;

        } catch (error) { throw new Error(error); }
    },


}

module.exports = Review