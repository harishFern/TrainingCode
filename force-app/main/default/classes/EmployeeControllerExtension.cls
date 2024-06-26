public class EmployeeControllerExtension {
    public List<Employee__c> employees { get; set; }
    public EmployeeControllerExtension() {
        employees = new List<Employee__c>();
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        String recId = ApexPages.currentPage().getParameters().get('id');
        System.debug('Record Id : '+ recordId);
        if (recordId != null) {
            fetchEmployee(recordId);
        } else if (recId != null) {
            fetchEmployee(recId);
        }
    }
    private void fetchEmployee(Id recordId) {
        employees = [SELECT Name, Position__c, Department__r.Name, Salary__c, Date_of_Joining__c
                     FROM Employee__c WHERE Id = :recordId];
    }
}