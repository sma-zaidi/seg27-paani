const express = require('express');
const Customer = require('../models/Review');

const router = express.Router();

router.post('/', async (req, res, next) => { // insert a review
	//id= customer_id
    var {id, review, rating} = req.body
    //review already exists or not
    try { 
        if(await Review.exists(id) == true) {
            return res.json({error: 'Review exists!'});
        }
    } catch (error) {
        return res.json({error: error});}
    

    try {
        await Review.create(id, review, rating);
        return res.json({error: false, msg: 'Review has been inserted.'});
    } catch (error) { return res.json({error: error}) };
})


module.exports = router