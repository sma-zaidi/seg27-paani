const express = require('express');

const Driver = require('../models/Driver');

const router = express.Router();

router.post('/', async (req, res, next) => {
    var {company_id, name, cnic, contact_number} = req.body;
    

    if (!company_id || !name || !cnic || !contact_number) {
        return res.json({error: 'Atleast one of the required fields: company_id, name, cnic, or contact_number is missing.'});
    }

    try { 
        if(await Driver.exists(cnic) == true) {
            return res.json({error: 'The provided cnic already has an account associated with it.'});
        }
    } catch (error) {
        return res.json({error: error});}
    
    try {
        result = await Driver.add(company_id, name, cnic, contact_number)
        return res.json({error:'false', msg:'Driver has been added.'})
    }catch(error){
        return res.json({error: error});
    }
})

router.get('/:companyid', async (req, res, next) => {
    company_id = req.params.companyid
    console.log("comp ", company_id)

    try{
        result = await Driver.getDrivers(company_id);
        return res.json({error:"false", msg:result})
    }catch (error){
        return res.json({error:error})
    }
})

module.exports = router