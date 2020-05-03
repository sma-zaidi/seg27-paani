const express = require('express');
const Company = require('../models/Company');

const router = express.Router();

router.get('/:companyid', async (req, res, next) => {

    try {

        companyid = req.params.companyid;
        result = await Company.getDrivers(companyid);
        return res.json({error: false, msg: result});

    } catch (error) {
        res.json({error: error});
    }
    
})

module.exports = router