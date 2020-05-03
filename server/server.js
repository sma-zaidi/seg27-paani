const express = require('express');
const morgan = require('morgan');
const bodyparser = require('body-parser');

const app = express();
app.use(morgan('combined'))
app.use(bodyparser.json()) 
app.use(bodyparser.urlencoded({ extended: true }))

// setting up routes
app.use('/users', require('./routes/users.routes'));
app.use('/companies', require('./routes/companies.routes'))
/* import your routes here like so:
    app.use('/packages', require('./routes/packages.routes));
*/

// start the server
port = process.env.PORT || 7777
app.listen(port, () => {
    console.log("Server up. Listening on port", port);
})