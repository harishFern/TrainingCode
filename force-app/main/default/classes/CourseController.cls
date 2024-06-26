public with sharing class CourseController {
    @AuraEnabled(cacheable=true)
    public static Course__c getCourseById(Id courseId) {
        return [SELECT Id, Name FROM Course__c WHERE Id = :courseId LIMIT 1];
    }
}