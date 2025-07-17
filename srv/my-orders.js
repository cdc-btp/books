const cds = require('@sap/cds')

module.exports = class MyOrdersService extends cds.ApplicationService {
  init() {
    // Add custom logic for MyOrders here if needed
    return super.init();
  }
} 