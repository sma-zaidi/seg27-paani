const express = require('express');
const Package = require('../models/Package');

const router = express.Router()

router.get('/:companyid', async (req, res, next) => { // get packages by company id
    try {
        companyid = req.params.companyid
        result = await Package.getByCompany(companyid)
        if (result.length === 0){
            return res.json({error: false, msg:"No Packages Found!"})
        }
        return res.json({error: false, msg: result})
    } catch (error) { console.log(error); res.json({error: error}); }
})

router.post('/', async (req, res, next) => { // create a package
    var {company_id, price_base, price_per_km, bowser_capacity} = req.body

    if (!company_id || !price_base || !price_per_km || !bowser_capacity) {
        return res.json({error: 'Atleast one of the required fields: company_id, price_base, price_km or bowser_capacity is missing.'});
    }

    try {
        await Package.create(company_id, price_base, price_per_km, bowser_capacity);
        return res.json({error: false, msg: 'Package created successfully.'});
    } catch (error) { console.log(error); return res.json({error: error}) };
})

router.put('/', async (req, res, next) => { // modify package
    var {package_id, price_base, price_per_km, bowser_capacity} = req.body

    if (!package_id || !price_base || !price_per_km || !bowser_capacity) {
        return res.json({error: 'Atleast one of the required fields: package_id, price_base, price_km or bowser_capacity is missing.'});
    }

    try {
        await Package.update(package_id, price_base, price_per_km, bowser_capacity);
        return res.json({error: false, msg: 'Package updated successfully.'});
    } catch (error) { console.log(error) ; return res.json({error: error}) };
})

router.delete('/:packageid', async (req, res, next) => { // delete a package
    package_id = req.params.packageid

    try {
        await Package.destroy(package_id);
        return res.json({error: false, msg: 'Package deleted successfully.'});
    } catch (error) { console.log(error); return res.json({error: error}); };
})

module.exports = router