/*
    SERVER ENTRY POINT
    
    * Routes and controllers are defined in /routes

    * Responses look like this
        {error: <error msg>} or 
        {error: false, msg: <response>} so always check for the error first.
*/

const express = require('express');
const morgan = require('morgan'); // logging
const bodyparser = require('body-parser');

const app = express();
app.use(morgan('combined'))
app.use(bodyparser.json()) 
app.use(bodyparser.urlencoded({ extended: true }))

// setting up routes
app.use('/users', require('./routes/users.routes'));
app.use('/companies', require('./routes/companies.routes'));
app.use('/drivers', require('./routes/drivers.routes'));
app.use('/packages', require('./routes/packages.routes'));
app.use('/orders', require('./routes/orders.routes'));
app.use('/customers', require('./routes/customers.routes'));
app.use('/reviews', require('./routes/reviews.routes'));
/* import your routes here like so:
    app.use('/packages', require('./routes/packages.routes));
*/

// start the server
port = process.env.PORT || 7777
app.listen(port, () => {
    console.log("Server up. Listening on port", port);
})