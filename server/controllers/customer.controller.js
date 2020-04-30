const Customer = require('../models/customer.model') //customer model.


exports.create_new_customer = async (request, response) => {

    customer = request.body

    if(!customer.name || !customer.contact_num || !customer.address || !customer.location){
        return response.status(400).json({
            message: 'Some field/s missing!',
            error: true
        })
    }

    await Customer.create(customer)
    .then(() => {
        return response.status(200).json({
            message: 'Customer registered!',
            error: false
        })
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
	
}

exports.get_all_customers = async (request, response) => {
	await Customer.getAll()
	.then((result) => {
		return response.status(200).json({
			message:result,
			error:false
		})
	}).catch((error) => {return response.status(400).json({message: error, error: true})});
}
