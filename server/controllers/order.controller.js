const Orders = require('../models/order.model'); 

exports.create_new_order = async (request, response) => {

    console.log('\n', request.body)
    
    order = request.body

    if(!order.customer_id || !order.package_id) {
        return response.status(400).json({
            message: 'Missing customer_id or package_id field',
            error: true
        })
    }

    order.customer_id = Number(order.customer_id);
    order.package_id = Number(order.package_id);
    order.order_status = 'Received';

    await Orders.create(order)
    .then(() => {
        return response.status(200).json({
            message: 'Record inserted',
            error: false
        })
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
    
}

exports.get_all_orders = async (request, response) => {
    await Orders.getAll()
    .then((result) => {
        return response.status(200).json({
            message: result,
            error: false
        });
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
}

exports.get_all_orders_by_company = async (company_id, request, response) => {
    await Orders.getAllByCompanyID(company_id)
    .then((result) => {
        return response.status(200).json({
            message: result,
            error: false
        });
    }).catch((error) => {return response.status(400).json({message: error, error: true})});
}