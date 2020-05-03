const express = require('express');
const Package = require('../models/Order');

const router = express.Router()

router.put('/', async (req, res, next) => { // edit order status
    var {order_id, status} = req.body

    if (!order_id || !status) {
        return res.json({error: 'Atleast one of the required fields: order_id or status is missing.'});
    }

    try {
        await Order.updateStatus(order_id, status);
        return res.json({error: false, msg: 'Order status has been updated.'});
    } catch (error) { console.log(error) ; return res.json({error: error}) };
})

router.get('/history/:customerid', async (req, res, next) => {
    try {
        customerid = req.params.customerid
        result = await Order.getOrderHistory(customerid)
        if (result.length === 0){
            return res.json({msg:"No Order History Found!"})
        }
        return res.json({msg:result})
    } catch (error) {
        res.json({error: error})
    }
})

router.get('/:customerid',async (req, res, next) => {
    try {
        customerid = req.params.customerid
        result = await Order.getLatestOrders(customerid)
        if (result.length === 0){
            return res.json({msg:"None Found!"})
        }
        return res.json({msg:result})
    } catch (error) {
        res.json({error: error})
    }
}
)

router.get('/:companyid/:status', async (req, res, next) => { // get orders by company and status.
    try {
        companyid = req.params.companyid
        status = req.params.status

        result = await Order.getByCompanyAndStatus(companyid, status)
        if (result.length === 0){
            return res.json({error: "No Orders Found!"})
        }
        return res.json({error: false, msg:result})
    } catch (error) {
        console.log(error);
        res.json({error: error})
    }
})

router.get('/:companyid', async (req, res, next) => {
    try {
        companyid = req.params.companyid
        result = await Order.getCompanyHistory(companyid)
        if (result.length === 0){
            return res.json({error:"No Order History Found!"})
        }
        return res.json({error: false, msg:result})
    } catch (error) {
        console.log(error)
        res.json({error: error})
    }
})


module.exports = router