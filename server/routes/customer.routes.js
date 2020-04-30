const express = require('express');
const customerController = require('../controllers/customer.controller')

const router = express.Router();

router.get('/', (req, res, next) => {
    customerController.get_all_customers(req,res);
});

router.post('/', (req, res, next) => {
    customerController.create_new_customer(req, res);
})

module.exports = router
