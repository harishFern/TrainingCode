public class DataSender {

    public static void sendSampleData() {
        String sampleJson = '{"Name": "Fern Software 01", "AccountNumber": "123456", "AccountSource": "Web", "AnnualRevenue": 1000000, "BillingAddress": {"city": "San Francisco", "country": "USA", "postalCode": "94105", "state": "CA", "street": "123 Market St"}, "Contacts": [{"FirstName": "John", "LastName": "Doe", "Email": "john.doe@example.com"}]}';
        HTTPCalloutService httpService = new HTTPCalloutService();
        httpService.sendData(sampleJson);
    }
}