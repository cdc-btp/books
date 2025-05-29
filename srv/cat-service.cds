using { sap.capire.bookshop as my } from '../db/schema';


service CatalogService @(requires: 'authenticated-user'){


  /** For displaying lists of Books */
  @restrict: [
    { grant: ['CREATE'], to: 'authenticated-user'  }, 
    { grant: ['READ'],  to: 'books:read'  },
    { grant: ['*'],  to: 'books:write'  }
  ]   
  @readonly entity ListOfBooks as projection on my.Books
  excluding { descr };
 

  /** For display in details pages */
  // @readonly entity Books as projection on my.Books { *,
  //   author.name as author
  // } excluding {  modifiedBy };

  // // /** For display in details pages */
  // @readonly entity MyBooks @(restrict : [  { grant: 'READ', where: 'createdBy = $user' } ]) as projection on Books { * } ;

  @requires: 'authenticated-user'
  action submitOrder (
    book    : my.Books:ID @mandatory,
    quantity: Integer  @mandatory
  ) returns { stock: Integer };

  event OrderedBook : { book: my.Books:ID; quantity: Integer; buyer: String };
}
