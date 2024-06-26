trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> tasksToCreate = new List<Task>();

    for (Opportunity opp : Trigger.new) {
        if (opp.StageName == 'Closed Won' && (Trigger.isInsert || (Trigger.isUpdate && opp.StageName != Trigger.oldMap.get(opp.Id).StageName))) {
            Task followUpTask = new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id,
                Status = 'Not Started',
                Priority = 'Normal'
            );
            tasksToCreate.add(followUpTask);
        }
    }

    if (!tasksToCreate.isEmpty()) {
        try {
            insert tasksToCreate;
        } catch (DmlException e) {
            // Handle exceptions (optional)
            System.debug('An error occurred while creating tasks: ' + e.getMessage());
        }
    }
}