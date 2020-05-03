const express = require('express');
const Package = require('../models/Packages');

const router = express.Router()

router.get('/:companyid', async (req, res, next) => {
    try {
        companyid = req.params.companyid
        result = await Package.getPackages(companyid)
        if (result.length === 0){
            return res.json({msg:"No Packages Found!"})
        }
        return res.json({msg:result})
    } catch (error) {
        res.json({error: error})
    }
})

module.exports = router