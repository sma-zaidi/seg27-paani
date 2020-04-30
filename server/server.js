const express = require('express');
const morgan = require('morgan');
const bodyparser = require('body-parser');

const app = express();
app.use(morgan('combined'))
app.use(bodyparser.json()) 
app.use(bodyparser.urlencoded({ extended: true }))


// setting up routes
const userRoutes = require('./routes/user.routes');
const customerRoutes = require('./routes/customer.routes');
const companyRoutes = require('./routes/company.routes');
const orderRoutes = require('./routes/order.routes');

app.use('/users', userRoutes);
app.use('/customers', customerRoutes);
app.use('/companies', companyRoutes);
app.use('/orders', orderRoutes);

app.get('/', (req, res) => {
    res.send('Software Engineering Group 27<br>It works!');
})


// start the server
port = process.env.PORT || 7777
app.listen(port, () => {
    console.log("Server up. Listening on port", port);
})