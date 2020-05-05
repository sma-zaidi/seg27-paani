const express = require('express');
const User = require('../models/User');
const Customer = require('../models/Customer');
const Company = require('../models/Company')

const router = express.Router();

/*
    Routes for '/users' and relevant controllers are implemented here.
    Don't forget to import your routes in server.js if you define them in another file!!
*/

// REGISTRATION
router.post('/register', async (req, res, next) => {

    var {email, password, account_type} = req.body;

    if (!email || !password) {
        return res.json({error: 'Atleast one of the required fields: email, or password is missing.'});
    }

    if (account_type == undefined) account_type = 'CUSTOMER'; // account_type defaults to 'CUSTOMER' if not explicitly provided
    if (account_type != 'CUSTOMER' && account_type != 'COMPANY') {
        return res.json({error: 'Incorrect value in account_type field: should be either \'CUSTOMER\' or \'COMPANY\''});
    }

    try { 
        if(await User.exists(email) == true) {
            return res.json({error: 'The provided email address already has an account associated with it.'});
        }
    } catch (error) { console.log(error); return res.json({error: error}); }

    ///////////////////////////////
    // handle customer registration
    if (account_type == 'CUSTOMER') {

        var {name, contact_number, address, location} = req.body;

        if(!name || !contact_number) { // require contact number?
             return res.json({error: 'Atleast one of the required fields: name, or contact_number is missing.'});
        }

        try {
            userid = await User.create(email, password, 'CUSTOMER');
        } catch (error) { console.log(error); return res.json({error: error}); }

        try {
            await Customer.create(userid, name, contact_number, address, location);
        } catch (error) {
            User.destroy(userid); // rollback changes if account creation fails midway.
            console.log(error);
            return res.json({error: error});
        }

        res.json({error: false, msg: 'Customer account creation successful, redirect to login.'});
    }

    //////////////////////////////
    // handle company registration
    else if (account_type == 'COMPANY') {

        var {name, ntn, contact_number, address, location} = req.body;

        if(!name || !ntn || !contact_number || !address || !location) {
            return res.json({error: 'Atleast one of the required fields: name, ntn, contact_number, address or location is missing.'})
        }

        try {
            userid = await User.create(email, password, 'COMPANY');
        } catch (error) { console.log(error); return res.json({error: error}); }

        try {
            await Company.create(20, name, ntn, contact_number, address, location);
        } catch (error) {
            User.destroy(userid); // user is created before customer, so if something goes wrong while creating the customer, need to roll back.
            console.log(error);
            return res.json({error: error});
        }

        res.json({error: false, msg: 'Company account creation successful, redirect to login.'});
    }

})

// LOGIN
router.post('/login', async (req, res, next) => {

    var {email, password} = req.body;

    if (!email || !password) {
        return res.json({error: 'Atleast one of the required fields: email, or password is missing.'});
    }

    try {
        if (await User.exists(email) == false) {
            return res.json({error: 'The provided email address has no account associated with it.'});
        }
    } catch (error) { console.log(error); return res.json({error: error}); }

    try {
        user = await User.getByEmail(email); // get the actual credentials associated with this email to validate password
    } catch (error) { console.log(error); return res.json({error: error}); }

    if (password != user.password) return res.json({error: 'Invalid login credentials'});

    ////////////////////////
    // handle customer login
    if (user.account_type == 'CUSTOMER') {
        try {
            result = await Customer.getById(user.id);
            return res.json({error: false, msg: result})
        } catch (error) { console.log(error); return res.json({error: error}); }
    }

    ///////////////////////
    // handle company login
    else if (user.account_type == 'COMPANY') {
        try {
            result = await Company.getById(user.id);
            return res.json({error: false, msg: result})
        } catch (error) { console.log(error); return res.json({error: error}); }
    }

})

module.exports = router