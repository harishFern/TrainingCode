trigger DepartmentTrigger on Department__c (before insert, before update) {
    Set<Id> managerIds = new Set<Id>();

    
    for (Department__c dept : Trigger.new) {
        if (dept.Manager__c != null) {
            managerIds.add(dept.Manager__c);
        }
    }

    if (!managerIds.isEmpty()) {
       
        List<Department__c> existingDepartments = [SELECT Id, Manager__c FROM Department__c WHERE Manager__c IN :managerIds];

        Map<Id, Id> existingManagerMap = new Map<Id, Id>();
        for (Department__c dept : existingDepartments) {
            existingManagerMap.put(dept.Manager__c, dept.Id);
        }

        
        for (Department__c dept : Trigger.new) {
            if (dept.Manager__c != null && existingManagerMap.containsKey(dept.Manager__c) && existingManagerMap.get(dept.Manager__c) != dept.Id) {
                dept.addError('The selected Manager is already assigned to another Department.');
            }
        }
    }
}