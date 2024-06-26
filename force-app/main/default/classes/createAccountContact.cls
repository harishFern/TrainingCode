public class createAccountContact {
     public static void createAccCon() {
         try{
        StaticResource resource = [SELECT Body FROM StaticResource WHERE Name = 'AccountAndContactData'];
        String jsonString = resource.Body.toString();
        Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        
        Account newAccount = new Account();
        newAccount.Name = 'Fern Software 01';
        newAccount.AccountNumber = (String) parsedData.get('AccountNumber');
        newAccount.AccountSource = (String) parsedData.get('AccountSource');
        newAccount.AnnualRevenue = (Decimal) parsedData.get('AnnualRevenue');
        Map<String, Object> billingAddress = (Map<String, Object>) parsedData.get('BillingAddress');
        newAccount.BillingCity = (String) billingAddress.get('city');
        newAccount.BillingCountry = (String) billingAddress.get('country');
        newAccount.BillingPostalCode = (String) billingAddress.get('postalCode');
        newAccount.BillingState = (String) billingAddress.get('state');
        newAccount.BillingStreet = (String) billingAddress.get('street');
        newAccount.Description = (String) parsedData.get('Description');
        newAccount.Fax = (String) parsedData.get('Fax');
        newAccount.Industry = (String) parsedData.get('Industry');
        newAccount.NumberOfEmployees = (Integer) parsedData.get('NumberOfEmployees');
        newAccount.Ownership = (String) parsedData.get('Ownership');
        newAccount.Phone = (String) parsedData.get('Phone');
        Map<String, Object> shippingAddress = (Map<String, Object>) parsedData.get('ShippingAddress');
        newAccount.ShippingCity = (String) shippingAddress.get('city');
        newAccount.ShippingCountry = (String) shippingAddress.get('country');
        newAccount.ShippingPostalCode = (String) shippingAddress.get('postalCode');
        newAccount.ShippingState = (String) shippingAddress.get('state');
        newAccount.ShippingStreet = (String) shippingAddress.get('street');
        newAccount.Sic = (String) parsedData.get('Sic');
        newAccount.Site = (String) parsedData.get('Site');
        newAccount.TickerSymbol = (String) parsedData.get('TickerSymbol');
        newAccount.Type = (String) parsedData.get('Type');
        newAccount.Website = (String) parsedData.get('Website');        
        insert newAccount;
        
        List<Contact> newContacts = new List<Contact>();
        List<Object> contacts = (List<Object>) parsedData.get('Contacts');
        for (Object contactObj : contacts) {
            Map<String, Object> contactData = (Map<String, Object>) contactObj;
            Contact newContact = new Contact();
            newContact.AccountId = newAccount.Id; 
            newContact.FirstName = (String) contactData.get('FirstName');
            newContact.LastName = (String) contactData.get('LastName');
            newContact.AssistantName = (String) contactData.get('AssistantName');
            newContact.AssistantPhone = (String) contactData.get('AssistantPhone');
            newContact.Birthdate = Date.valueOf((String) contactData.get('Birthdate'));
            newContact.Department = (String) contactData.get('Department');
            newContact.Description = (String) contactData.get('Description');
            newContact.Email = (String) contactData.get('Email');
            newContact.Fax = (String) contactData.get('Fax');
            newContact.HomePhone = (String) contactData.get('HomePhone');
            newContact.LeadSource = (String) contactData.get('LeadSource');
            Map<String, Object> mailingAddress = (Map<String, Object>) contactData.get('MailingAddress');
            newContact.MailingCity = (String) mailingAddress.get('city');
            newContact.MailingCountry = (String) mailingAddress.get('country');
            newContact.MailingPostalCode = (String) mailingAddress.get('postalCode');
            newContact.MailingState = (String) mailingAddress.get('state');
            newContact.MailingStreet = (String) mailingAddress.get('street');
            newContact.MobilePhone = (String) contactData.get('MobilePhone');
            Map<String, Object> otherAddress = (Map<String, Object>) contactData.get('OtherAddress');
            newContact.OtherCity = (String) otherAddress.get('city');
            newContact.OtherCountry = (String) otherAddress.get('country');
            newContact.OtherPostalCode = (String) otherAddress.get('postalCode');
            newContact.OtherState = (String) otherAddress.get('state');
            newContact.OtherStreet = (String) otherAddress.get('street');
            newContact.OtherPhone = (String) contactData.get('OtherPhone');
            newContact.Phone = (String) contactData.get('Phone');
            newContact.Title = (String) contactData.get('Title');
            newContacts.add(newContact);
        }        
        insert newContacts;
         }  catch(Exception e){
             system.debug('exception: '+e.getMessage());
         }
    }
}