public with sharing class StudentController {
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudents(Id courseId) {
        return [SELECT Id, Name, Roll_No__c, Email__c, Enrollment_Date__c 
                FROM Student__c 
                WHERE Course__c = :courseId];
    }
}