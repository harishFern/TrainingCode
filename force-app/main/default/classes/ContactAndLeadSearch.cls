public class ContactAndLeadSearch {

    // Method to search for contacts and leads based on a name parameter
    public static List<List<sObject>> searchContactsAndLeads(String name) {
        // Define the SOSL query to find contacts and leads with the specified first or last name
        List<List<sObject>> searchResults = [FIND :name IN NAME FIELDS RETURNING 
                                              Contact(Id, FirstName, LastName), 
                                              Lead(Id, FirstName, LastName)];
        
        return searchResults;
    }
}