const express = require('express');
const userController = require('../controllers/user.controller');

const router = express.Router();

router.get('/', (req, res, next) => {
    userController.get_all_users(req, res);
});

router.post('/', (req, res, next) => {
    userController.create_new_user(req, res);
})

router.get('/:email', (req, res, next) => {
    userController.check_user_exists(req.params.email, req, res);
})

router.post('/login', (req, res, next) => {
    userController.login(req, res);
})

module.exports = router