


POLICY "my-books" { 
    USE "grant-read" RESTRICT owner = $user.id;
    USE "grant-write" RESTRICT owner = $user.id; 
}

POLICY "grant-read" {
    GRANT READ ON * WHERE owner IS NOT RESTRICTED;
}

POLICY "grant-write" {
    GRANT UPDATE ON *  WHERE owner IS NOT RESTRICTED ; 
}

 
