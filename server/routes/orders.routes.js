const express = require('express');
const Package = require('../models/Order');

const router = express.Router()

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

module.exports = router