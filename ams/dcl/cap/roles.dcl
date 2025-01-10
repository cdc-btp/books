
POLICY "Junior" {
    USE "books-read" RESTRICT genre IN ('Fantasy', 'Fairy Tale'), price < 20;
}
 
 
POLICY "Member" { 
    USE "books-read"; 
}
 
POLICY "Admin" {
	USE "books-write";
	USE "books-read";
}

