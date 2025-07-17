using { sap.capire.bookshop as my } from '../db/schema';

@restrict: [{ grant:['READ'], to: ['authenticated-user'] }]
service MyOrders@(path: '/my-orders', requires: 'authenticated-user')  {
  @readonly
  entity Order as select from my.Orders { *, Items } where buyer=$user.id;
  @readonly 
  entity Product as projection on my.Books excluding { author };
} 