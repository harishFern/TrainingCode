@isTest
public class DailyLeadProcessorTest {
    @testSetup
    static void setup() {
        // Insert 200 Lead records with blank LeadSource
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Test' + i, Company = 'TestCompany' + i));
        }
        insert leads;
    }

    @isTest
    static void testDailyLeadProcessor() {
        // Schedule the DailyLeadProcessor to run
        String jobId = System.schedule('Test DailyLeadProcessor Job', '0 0 0 * * ?', new DailyLeadProcessor());

        // Retrieve the list of scheduled jobs
        List<CronTrigger> cronTriggers = [SELECT Id, CronJobDetail.Name, State FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals(1, cronTriggers.size(), 'The job should be scheduled.');
        System.assertEquals('WAITING', cronTriggers[0].State, 'The job should be in WAITING state.');

        // Execute the scheduled job
        Test.startTest();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            CronTrigger ct = [SELECT Id, CronJobDetail.Name, State, NextFireTime FROM CronTrigger WHERE Id = :jobId];
            if (ct.NextFireTime != null) {
                System.schedule('Test DailyLeadProcessor Job', '0 0 0 * * ?', new DailyLeadProcessor());
            }
            Test.stopTest();
        }

        // Verify that all Lead records were updated correctly
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'All 200 leads should be updated with LeadSource = Dreamforce.');
    }
}