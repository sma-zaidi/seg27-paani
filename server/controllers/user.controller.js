const Users = require('../models/user.model'); // model of the user. A class with attributes a user has e.g email, password
                                             // methods of this class interact with the database directly. You will write your queries there.

exports.check_user_exists = async (email_address, request, response) => {
    
    await Users.getByEmail(email_address)
    .then(async (result) => {
        if(result.length) return response.status(200).json({message: true, error: false});
        else return response.status(200).json({message: false, error: false});
    }).catch((error) => {return response.status(400).json({message: error, error: true})});

}

exports.create_new_user = async (request, response) => {
    
    user = request.body

    if(!user.email_address || !user.password) {
        return response.status(400).json({
            message: 'Missing email_address or password field',
            error: true
        })
    }

    await Users.getByEmail(user.email_address)
    .then(async (result) => {
        if(result.length) return response.status(400).json({message: 'An account with that email address already exists', error: true})
        else {
            result = await Users.create(user)
            .then(() => {
                return response.status(200).json({
                    message: 'Record inserted',
                    error: false
                })
            }).catch((error) => {return response.status(400).json({message: error, error: true})});
        }
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
    
}

exports.get_all_users = async (request, response) => {
    await Users.getAll()
    .then((result) => {
        return response.status(200).json({
            message: result,
            error: false
        });
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
}

exports.login = async (request, response) => {

    email_address = request.body.email_address;
    password = request.body.password;

    await Users.getByEmail(email_address)
    .then((result) => {
        if(result.length) {
            result = result.map(v => Object.assign({}, v));
            if(password == result[0].password) return response.status(200).json({message: 'OK', error: false});
        }
        return response.status(400).json({
            message: 'Incorrect email address or password',
            error: true
        })
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
    
}