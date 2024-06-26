public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numContacts, String lastName) {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 0; i < numContacts; i++) {
            Contact newContact = new Contact();
            newContact.FirstName = 'Test ' + i;
            newContact.LastName = lastName;
            contacts.add(newContact);
        }
        
        return contacts;
    }
}