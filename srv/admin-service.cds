using {sap.capire.bookshop as my} from '../db/schema';

service AdminService @(requires: 'authenticated-user') {
 
      /** For display in details pages */
    entity Books as projection on my.Books;
    entity Authors as projection on my.Authors;
    
    entity MyBooks @(restrict : [  { grant: 'READ', where: 'createdBy = $user' } ])  as select from  Books {
      ID,
      price,
      owner,
      genre

    };

    
}
