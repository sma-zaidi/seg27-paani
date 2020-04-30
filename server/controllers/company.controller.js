const Companies = require('../models/company.model'); // model of the user. A class with attributes a user has e.g email, password
                                             // methods of this class interact with the database directly. You will write your queries there.

exports.get_all_companies = async (request, response) => {
    await Companies.getAll()
    .then((result) => {
        return response.status(200).json({
            message: result,
            error: false
        });
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
}