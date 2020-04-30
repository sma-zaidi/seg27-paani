const express = require('express');
const companyController = require('../controllers/company.controller'); // handles transaction with the database, and returns a response accordingly.
                                                                 // any checks e.g email taken are also handled by this

const router = express.Router(); // create an instance of a router, which will store all our routes defined below

router.get('/', (req, res, next) => { // define how to handle requests to www.[whatever].com/user
    companyController.get_all_companies(req, res);
});

module.exports = router // export the router, so these routes can be made available in other scripts that import them using require().