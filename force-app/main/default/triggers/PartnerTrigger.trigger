trigger PartnerTrigger on Partner__c (before insert) {
    SWITCH ON Trigger.operationtype{
        WHEN BEFORE_INSERT{
            DuplicatePartnerTriggerHandler.preventDuplicates(Trigger.new);
        }
    }
}