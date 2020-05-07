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
    var {customer_id, package_id, delivery_address, delivery_location, delivery_time, estimated_cost, cost} = req.body

    if (!customer_id || !package_id || !delivery_time) {
        return res.json({error: 'Atleast one of the required fields: customer_id, package_id or delivery_time is missing.'});
    }

    if (!delivery_address && !delivery_location) {
        return res.json({error: 'Provide atleast one of delivery_address and delivery_location'});
    }

    try {
        //no previous orders, create new order
        if(await Order.exists(customer_id) == false)
        {
            await Order.PlaceOrder(customer_id, package_id, delivery_address, delivery_location, delivery_time, estimated_cost, cost);
            return res.json({error: false, msg: 'Order has been added.'});}
        //can not create a new order if previous isn't completed
        else {
            result = await Order.getlatestOrder(customer_id)
            if(result[0].status != "Complete" && result[0].status != "Declined" && result[0].status != "Cancelled") { // the 3 possible end states of an order
                return res.json({error: 'Another order is in progress.'});
            }
            await Order.PlaceOrder(customer_id, package_id, delivery_address, delivery_location, delivery_time, estimated_cost, cost);
            return res.json({error: false, msg: 'Order has been added.'});
        }    


    } catch(error){
        console.log(error);
        return res.json({error: error});
    }
        
})


router.get('/history/:customerid', async (req, res, next) => {
    try {
        customerid = req.params.customerid
        result = await Order.getOrderHistory(customerid);
        if (result.length === 0){
            return res.json({msg:"No Order History Found!"})
        }
        return res.json({msg:result})
    } catch (error) {
        res.json({error: error})
    }
})

router.get('/rating/:orderid', async (req, res, next) => {
    try {
        orderid = req.params.orderid
        result = await Order.rating(orderid);
        if (result.length === 0){
            return res.json({msg:"No completed order!"})
        }
        return res.json({msg:result})
    } catch (error) {
        res.json({error: error})
    }
})

router.get('/:customerid',async (req, res, next) => {
    try {
        customerid = req.params.customerid
        result = await Order.getlatestOrder(customerid);
        if (result.length === 0){
            return res.json({msg:"None Found!"})
        }
        return res.json({error: false, msg:result[0]})
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