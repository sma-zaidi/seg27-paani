const express = require('express');
const orderController = require('../controllers/order.controller');

const router = express.Router();

router.get('/', (req, res, next) => {
    orderController.get_all_orders(req, res);
});

router.post('/', (req, res, next) => {
    orderController.create_new_order(req, res);
})

router.get('/:companyid', (req, res, next) => {
    orderController.get_all_orders_by_company(req.params.companyid, req, res);
})

module.exports = router 