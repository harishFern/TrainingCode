trigger EmployeeTrigger on Employee__c (before insert, before update) {
    Set<Id> contactIds = new Set<Id>();

   
    for (Employee__c emp : Trigger.new) {
        if (emp.Contact__c != null) {
            contactIds.add(emp.Contact__c);
        }
    }

    if (!contactIds.isEmpty()) {
        
        List<Employee__c> existingEmployees = [SELECT Id, Contact__c FROM Employee__c WHERE Contact__c IN :contactIds];

        Map<Id, Id> existingEmployeeMap = new Map<Id, Id>();
        for (Employee__c emp : existingEmployees) {
            existingEmployeeMap.put(emp.Contact__c, emp.Id);
        }

        
        for (Employee__c emp : Trigger.new) {
            if (emp.Contact__c != null && existingEmployeeMap.containsKey(emp.Contact__c) && existingEmployeeMap.get(emp.Contact__c) != emp.Id) {
                emp.addError('The selected Contact already has an existing Employment record.');
            }
        }
    }
}