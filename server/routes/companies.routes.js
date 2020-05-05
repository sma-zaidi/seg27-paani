const express = require('express');
const Company = require('../models/Company');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        companies = await Company.getAll()
        if (companies.length == 0){
            return res.json({error: true, msg:"No Company Records Available!"})
        }
        return res.json({error: false, msg: companies})
        
    } catch (error) { console.log(error); return res.json({error: error}); }
})

module.exports = router