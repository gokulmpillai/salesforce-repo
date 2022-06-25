trigger AccountTrigger on Account (after update) {
    SWITCH ON Trigger.OperationType{
        WHEN AFTER_UPDATE{
            OpportunityStatusUpdateHandler.MakeOpportunityClosed(Trigger.new);
        }
    }
}