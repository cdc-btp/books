using { sap.capire.bookshop as my } from '../db/schema';


service CatalogService @(requires: 'authenticated-user'){


  /** For displaying lists of Books */
  @readonly entity ListOfBooks as projection on Books
  excluding { descr };
 

  /** For display in details pages */
  @readonly entity Books as projection on my.Books { *,
    author.name as author
  } excluding {  modifiedBy };

  /** For display in details pages */
  @readonly entity MyBooks @(restrict : [  { grant: 'READ', where: 'createdBy = $user' } ]) as projection on Books { * } ;

  @requires: 'authenticated-user'
  action submitOrder (
    book    : Books:ID @mandatory,
    quantity: Integer  @mandatory
  ) returns { stock: Integer };

  event OrderedBook : { book: Books:ID; quantity: Integer; buyer: String };
}
