public class ContactSearch {
    
    // Method to search for contacts based on last name and mailing postal code
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        // Query to find contacts with the specified last name and mailing postal code
        List<Contact> contacts = [
            SELECT Id, Name
            FROM Contact
            WHERE LastName = :lastName AND MailingPostalCode = :postalCode
        ];
        
        return contacts;
    }
}