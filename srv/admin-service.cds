using { sap.capire.bookshop as my } from '../db/schema';

service AdminService @(requires:'admin', path: '/admin') {
  entity Books as projection on my.Books;
  entity Genres as projection on my.Genres;
  entity Authors as projection on my.Authors; 
}
