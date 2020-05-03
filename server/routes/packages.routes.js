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
    var {company_id, price_base, price_per_km, bowser_capacity} = req.body

    if (!company_id || !price_base || !price_per_km || !bowser_capacity) {
        return res.json({error: 'Atleast one of the required fields: company_id, price_base, price_km or bowser_capacity is missing.'});
    }

    try {
        await Package.create(company_id, price_base, price_per_km, bowser_capacity);
        return res.json({error: false, msg: 'Package has been added.'});
    } catch (error) { return res.json({error: error}) };
})

router.put('/', async (req, res, next) => { // create a package
    var {package_id, price_base, price_per_km, bowser_capacity} = req.body

    if (!package_id || !price_base || !price_per_km || !bowser_capacity) {
        return res.json({error: 'Atleast one of the required fields: package_id, price_base, price_km or bowser_capacity is missing.'});
    }

    try {
        await Package.update(package_id, price_base, price_per_km, bowser_capacity);
        return res.json({error: false, msg: 'Package has been updated.'});
    } catch (error) { console.log(error) ; return res.json({error: error}) };
})

router.delete('/', async (req, res, next) => { // delete a package
    var {package_id} = req.body

    if (!package_id) {
        return res.json({error: 'Atleast one of the required fields: package_id is missing.'});
    }

    try {
        await Package.destroy(package_id);
        return res.json({error: false, msg: 'Package has been deleted.'});
    } catch (error) { console.log(error) ; return res.json({error: error}) };
})

module.exports = router