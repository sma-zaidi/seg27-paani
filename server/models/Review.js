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
    
    getAvgCompanyRating: async (companyid) => {
        try{
            result = await query(`SELECT AVG(rating) FROM \`seg27-paani\`.reviews 
                                    INNER JOIN \`seg27-paani\`.orders ON \`seg27-paani\`.reviews.id = \`seg27-paani\`.orders.id
                                    INNER JOIN \`seg27-paani\`.packages ON \`seg27-paani\`.orders.package_id = \`seg27-paani\`.packages.id
                                    INNER JOIN \`seg27-paani\`.companies ON \`seg27-paani\`.packages.company_id = \`seg27-paani\`.companies.id
                                    WHERE companies.id = ?`, [companyid]);         
        }
        catch (error) {throw new Error(error)}
    }


}

module.exports = Review
