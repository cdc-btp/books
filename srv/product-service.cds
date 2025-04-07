using { Currency, sap, managed, cuid} from '@sap/cds/common';

service ProductsService @(requires: 'authenticated-user') {
 entity Products @(restrict: [
   { grant: '*',
     where: 'exists producers.division[$user.division = name]'}]): cuid {
    producers : Association to many ProducingDivisions
                on producers.product = $self;
  }
  @readonly entity ProducingDivisions {
    key product : Association to Products;
    key division : Association to Divisions;
  }
  @readonly entity Divisions : cuid {
    name : String;
    producedProducts : Association to many ProducingDivisions
                       on producedProducts.division = $self;
  }
  
  
}