const express = require('express');
const Driver = require('../models/Driver');

const router = express.Router();

router.post('/', async (req, res, next) => { // create a driver
    var {company_id, name, cnic, contact_number} = req.body;

    if (!company_id || !name || !cnic || !contact_number) {
        return res.json({error: 'Atleast one of the required fields: company_id, name, cnic, or contact_number is missing.'});
    }
    
    try {
        result = await Driver.create(company_id, name, cnic, contact_number);
        return res.json({error: false, msg: 'Driver added successfully.'});
    } catch (error) { console.log(error); return res.json({error: error}); }
})

router.put('/', async (req, res, next) => { // update a driver's details
    var {driver_id, name, cnic, contact_number} = req.body

    if (!driver_id || !name || !cnic || !contact_number) {
        return res.json({error: 'Atleast one of the required fields: driver_id, name, cnic, or contact_number is missing.'});
    }

    try {
        await Driver.update(driver_id, name, cnic, contact_number);
        return res.json({error: false, msg: 'Driver details has been updated.'});
    } catch (error) { console.log(error) ; return res.json({error: error}) };
})

router.get('/:companyid', async (req, res, next) => { // get a company's drivers
    company_id = req.params.companyid

    try {
        result = await Driver.getByCompany(company_id);
        return res.json({error: false, msg: result})
    } catch (error) { console.log(error); return res.json({error:error}); }
})

router.delete('/:driverid', async (req, res, next) => { // delete a driver
    driver_id = req.params.driverid

    try {
        result = await Driver.destroy(driver_id);
        return res.json({error:"false", msg:result})
    } catch (error) { console.log(error); return res.json({error:error}); }
})

module.exports = router
