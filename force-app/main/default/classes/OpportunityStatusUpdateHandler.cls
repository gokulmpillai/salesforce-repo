public class OpportunityStatusUpdateHandler {
    public static void MakeOpportunityClosed(List<Account> listOfUpdatedAccounts){
        Set<Id> accountIds = new Set<Id>();
    for(Account acc : listOfUpdatedAccounts){
        accountIds.add(acc.Id);
    }
    
    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    
    for(Opportunity opp : [SELECT Id, CreatedDate, StageName 
                           FROM Opportunity
                           WHERE AccountId IN :accountIds
                           AND   StageName != 'Closed Won'
                          ]){
                              DateTime olderDate = System.now() - 30;
                              DateTime oppCreatedDate = opp.CreatedDate;
                              if(oppCreatedDate < olderDate){
                                  opp.StageName = 'Closed Lost';
                                  opp.CloseDate= System.today();
                                  opportunitiesToUpdate.add(opp);
                              }
                          }
    update opportunitiesToUpdate;
    }
}