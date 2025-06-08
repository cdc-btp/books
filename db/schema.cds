using { Currency, managed, sap } from '@sap/cds/common';
using { stocked, media } from '../srv/aspects';
namespace sap.capire.bookshop;


entity Books : managed, media, stocked {
  key ID : Integer;
  @mandatory title  : localized String(111);
  @mandatory author : Association to Authors;
  price  : Decimal;
  currency : Currency;
  image : LargeBinary @Core.MediaType : 'image/png';
}

annotate Books with @ams.alias : 'books';

entity Authors : managed {
  key ID : Integer;
  @mandatory name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}
