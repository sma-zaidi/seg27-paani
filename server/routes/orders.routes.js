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

router.post('/', async (req, res, next) => { // create an order
    var {customerid, package_id, delivery_address, delivery_location, delivery_time, status, created, last_update, cost} = req.body

    if (!customerid || !package_id || !delivery_time || !status || !created || !last_update || !cost) {
        return res.json({error: 'Atleast one of the required fields: customerid, package_id, delivery_time, status, created, last_update, cost is missing.'});
    }
    else if (!delivery_address && !delivery_location){
        return res.json({error: 'Both delivery_address and delivery_location are missing.'});
    }
    //No incomplete order
    try { 
        if(await Order.ongoing(customerid) == true) {
            return res.json({error: 'Another order is in progress.'});
        }
    } catch (error) {
        return res.json({error: error});}
    
    try {
        await Order.PlaceOrder(customerid, package_id, delivery_address, delivery_location, delivery_time, status, created, last_update, cost);
        return res.json({error: false, msg: 'Order has been added.'});
    } catch (error) { return res.json({error: error}) };
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
        result = await Order.getlatestOrder(customerid)
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