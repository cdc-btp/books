const cds = require('@sap/cds')

class AdminService extends cds.ApplicationService { init() {

  const { Books } = cds.entities('sap.capire.bookshop')
  const { ListOfBooks } = this.entities

  this.on('addBook', async req => {
    const { title, author, price, stock } = req.data
    return await INSERT(Books).with({title, author, price, stock})
  })

  this.on('deleteBook', async req => {
    const { id } = req.data
    await DELETE(Books, id)
    return { message: 'Book deleted successfully' }
  })
}   
}

module.exports = AdminService