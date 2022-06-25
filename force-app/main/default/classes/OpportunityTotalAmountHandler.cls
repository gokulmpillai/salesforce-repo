public class OpportunityTotalAmountHandler {
    public static void CalculateTotalOpportunityAmount(List<Opportunity> listOfOpportunities){
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> mapOfAccountsToUpdate = new Map<Id, Account>();
        
        //Fetching the Account Id of all the opportunities
        for(Opportunity opp : listOfOpportunities){
            if(!listOfOpportunities.isEmpty())
                accountIds.add(opp.AccountId);
		}
        
        //Iterating through opportunities to fetch sum of opportunities related to an account
        for(AggregateResult aggrObj : [SELECT AccountId, SUM(Amount)totalAmount 
                                                FROM Opportunity
                                                WHERE AccountId IN :accountIds
                                                GROUP BY AccountId]){
            	Account acc = new Account();
                acc.Id = (Id)aggrObj.get('AccountId');                                   
            	acc.Total_Amount__c = (Decimal)aggrObj.get('totalAmount');
                mapOfAccountsToUpdate.put(acc.Id, acc);                                    
        }
        
        update  mapOfAccountsToUpdate.values();
    }
}