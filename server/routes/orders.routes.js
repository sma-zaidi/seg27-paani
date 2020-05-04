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

router.get('/:companyid/:status', async (req, res, next) => {
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

module.exports = router