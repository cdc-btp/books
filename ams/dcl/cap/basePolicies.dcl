// ---------------------------------HEADER_START-----------------------------------------------
// Generated from a CAP model by the SAP AMS Plugin (@sap/ams) 2.1.1
// hash of generated content: 044a8cfd47519223b67ca966979957f1280ebc106b4e0a59cdc85dc387f2a508
// ----------------------------------HEADER_END------------------------------------------------



POLICY "books-write" {
    ASSIGN ROLE "books:write" WHERE owner IS NOT RESTRICTED;
}

POLICY "books-read" {
    ASSIGN ROLE "books:read" WHERE  genre IS NOT RESTRICTED AND price IS NOT RESTRICTED ;
}






