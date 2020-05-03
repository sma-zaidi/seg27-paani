const express = require('express');
const Company = require('../models/Company');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        companies = await Company.getAll()
        if (companies.length == 0){
            return res.json({msg:"No Company Records Available!"})
        }
        return res.json({msg:companies})
        
    } catch (error) {
        return res.json({error: error});
    }
})

module.exports = router