const cds = require('@sap/cds')

module.exports = class AdminService extends cds.ApplicationService { init(){

  const { Books } = this.entities

  /**
   * Generate IDs for new Books drafts
   */
  this.before ('NEW', Books.drafts, async (req) => {
    if (req.data.ID) return
    const { ID:id1 } = await SELECT.one.from(Books).columns('max(ID) as ID')
    const { ID:id2 } = await SELECT.one.from(Books.drafts).columns('max(ID) as ID')
    req.data.ID = Math.max(id1||0, id2||0) + 1
  })
  
  this.before("*", (req) => {
    console.log(`> ${req.method} ${req.target.name} ...`)
    console.log(req.user)
    // console.log(req.data)
    // console.log(req.model)
    console.log("target",  req.target.kind,req.target.name)
    console.log("entity", req.entity)
    console.log("model", req.model)

    console.log("query",req.query.elements)
    

  })
  this.before("EDIT", (req) => {
    console.log(`EDIT::::> ${req.method} ${req.target.name} ...`)
    console.log(req.user)
    console.log(req.data)
    console.log(req.model)
    

  })
  return super.init()
}}
