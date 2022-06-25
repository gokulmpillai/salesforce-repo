public class DuplicatePartnerTriggerHandler {
    public static void preventDuplicates(List<Partner__c> listOfNewPartners){
        
        Set<Id> accountIds = new Set<Id>();
    	Set<Id> opportunityIds = new Set<Id>();
		Map<Id, Partner__c> mapOfPartnerAccounts = new Map<Id, Partner__c>();
    	Map<Id, Partner__c> mapOfPartnerOpportunities = new Map<Id, Partner__c>();
    
    for(Partner__c partner : listOfNewPartners){
        accountIds.add(partner.Account__c);
        opportunityIds.add(partner.Opportunity__c);
    }

    
		for(Partner__c partnerObj: [SELECT Id, Account__c, Opportunity__c
                                     FROM   Partner__c
                                   	WHERE  Account__c IN :accountIds 
                                   	AND    Opportunity__c IN :opportunityIds]){
                               mapOfPartnerAccounts.put(partnerObj.Account__c, partnerObj);
                               mapOfPartnerOpportunities.put(partnerObj.Opportunity__c, partnerObj);                                         
                                     }    
    
    for(Partner__c partnerObj2 : listOfNewPartners){
        if(mapOfPartnerAccounts.containsKey(partnerObj2.Account__c) && mapOfPartnerOpportunities.containsKey(partnerObj2.Opportunity__c))
            partnerObj2.addError('Partner with same account exists');
    	}        
    }
}