trigger OpportunityTrigger on Opportunity (after insert, after update) {
    
    SWITCH ON Trigger.operationType{
        WHEN AFTER_INSERT{
            OpportunityTotalAmountHandler.CalculateTotalOpportunityAmount(Trigger.new);
            AddContactRoleHandler.AddOpportunityContactRole(Trigger.new);
        }
        WHEN AFTER_UPDATE{
            OpportunityTotalAmountHandler.CalculateTotalOpportunityAmount(Trigger.new);
        }
    }
}