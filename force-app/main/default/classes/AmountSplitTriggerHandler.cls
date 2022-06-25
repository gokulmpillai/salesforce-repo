public class AmountSplitTriggerHandler {
    public static void AmountSplitAfterUpdate(List<Contact> listOfInsertedContacts){
        Set<Id> accountIds = new Set<Id>();
        for(Contact conObj : listOfInsertedContacts){
            if(conObj.AccountId != NULL)
			accountIds.add(conObj.AccountId);
        }
        List<Account> listOfAccountsWithContacts = [SELECT Id, Name, Balance__c, 
                                                   (SELECT Id, Name, Individual_Balance__c 
                                                    FROM Contacts) 
                                                    FROM Account
                                                    WHERE Balance__c > 0];
        
        List<Contact> listOfContactsToUpdate = new List<Contact>();
        
        for(Account accObj : listOfAccountsWithContacts){
                Decimal totalContactsPerAccount = accObj.contacts.size();
                Decimal totalAmountPerContact = accObj.Balance__c/totalContactsPerAccount;
                System.debug('Total Contacts Per Account: '+ totalContactsPerAccount);
                System.debug('totalAmountPerContact: '+ totalAmountPerContact);
                for(Contact con : accObj.contacts){
                         con.Individual_Balance__c =  totalAmountPerContact;
                    System.debug('con.Individual_Balance__c'+ con.Individual_Balance__c	);
                    System.debug('totalAmountPerContact: '+totalAmountPerContact);
                }
          }
    }
}