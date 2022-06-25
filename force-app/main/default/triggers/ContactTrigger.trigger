trigger ContactTrigger on Contact (before insert, before update, after insert, after update, after delete, after undelete) {
	SWITCH ON Trigger.operationType{
        WHEN BEFORE_INSERT{
            ContactEmailDuplicateHandler.ContactEmailDuplicateCheckOnInsert(Trigger.new);
        }
        WHEN BEFORE_UPDATE{
			ContactEmailDuplicateHandler.ContactEmailDuplicateCheckOnUpdate(Trigger.new, Trigger.oldMap);
            AmountSplitTriggerHandler.AmountSplitAfterUpdate(Trigger.new);
        }
        WHEN AFTER_UPDATE{
        }
    }
}