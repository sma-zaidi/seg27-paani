const express = require('express');
const Package = require('../models/Packages');

const router = express.Router()

router.get('/:companyid', async (req, res, next) => { // get packages by company id
    try {
        companyid = req.params.companyid
        result = await Package.getPackages(companyid)
        if (result.length === 0){
            return res.json({error: 'false', msg:"No Packages Found!"})
        }
        return res.json({error: 'false', msg:result})
    } catch (error) {
        res.json({error: error})
    }
})

router.post('/', async (req, res, next) => { // create a package
    var {company_id, price_base, price_per_km} = req.body

    if (!company_id || !price_base || !price_per_km) {
        return res.json({error: 'Atleast one of the required fields: company_id, price_base, or price_km is missing.'});
    }

    try {
        await Package.create(company_id, price_base, price_per_km);
        return res.json({error: false, msg: 'Package has been added.'});
    } catch (error) { return res.json({error: error}) };
})

module.exports = router