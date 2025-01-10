using { Currency, sap, managed} from '@sap/cds/common';
namespace sap.capire.bookshop;


aspect media:managed  {
    price: Integer;
    genre: Association to Genres;
    owner  : String  @cds.on.insert : $user.id;

}

annotate media with @ams.attributes: {
    price: (price),
    genre: (genre.name),
    owner: (owner)
};
 
annotate media with @ams.publicFields: {
    price: (price),
    genre: (genre.name),
    owner: (owner)

};
 

@restrict: [
    { grant: ['CREATE'], to: 'authenticated-user'  }, 
    { grant: ['READ'],  to: 'books:read'  },
    { grant: ['*'],  to: 'books:write'  }
]    
entity Books : media {
  key ID : Integer;
  @mandatory title  : localized String(111);
  descr  : localized String(1111);
  @mandatory author : Association to Authors;
  genre  : Association to Genres;
  stock  : Integer;
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
