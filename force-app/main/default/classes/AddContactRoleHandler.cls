/*
This handler creates an opportunity contact role record with Role as Business User
whenever an opportunity is created from the related account's contacts
*/
public class AddContactRoleHandler {
    public static void AddOpportunityContactRole(List<Opportunity> newOpportunities){
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity oppObj : newOpportunities){
            accountIds.add(oppObj.AccountId);
        }
        
        Map<Id, List<Contact>> mapOfContacts = new Map<Id, List<Contact>>();
        
        for(Contact conObj : [SELECT Id, AccountId, Name 
                              FROM Contact 
                              WHERE AccountId IN :accountIds]){
                                  mapOfContacts.put(conObj.AccountId, new List<Contact>());
                                  mapOfContacts.get(conObj.AccountId).add(conObj);             
                              }
        
        List<OpportunityContactRole> listOfOCR= new List<OpportunityContactRole>();
        
        for(Opportunity opp : newOpportunities){
            if(mapOfContacts.containsKey(opp.AccountId) && mapOfContacts.get(opp.AccountId)!= Null)
                for(Contact con : mapOfContacts.get(opp.AccountId)){
                    OpportunityContactRole ocr = new OpportunityContactRole();
                    ocr.ContactId = con.Id;
                    ocr.OpportunityId = opp.Id;
                    ocr.Role = 'Business User';
                    listOfOCR.add(ocr);
                    System.debug('List of OCR: ' + listOfOCR);
                }
        }
        if(!listOfOCR.isEmpty())
            insert listOfOCR;
    }
}