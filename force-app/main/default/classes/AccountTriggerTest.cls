@isTest
public class AccountTriggerTest {
	@isTest
    static void setup(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.AccountId = acc.Id;
        opp.Amount = 10000;
        opp.StageName = 'Prospect';
        opp.CloseDate = System.today();
        insert opp;
        Datetime thirtyDaysBack = Datetime.now().addDays(-100);
        Test.setCreatedDate(opp.id, thirtyDaysBack);
    } 
    @isTest 
    static void createOpportunityTest(){
        List<Account> listAcc = [SELECT Id, Name FROM Account];
                List<Account> listAccToUpdate = new List<Account>();
        for(Account acc : listAcc){
            acc.Name = 'Test Account2';
            listAccToUpdate.add(acc);
        }
        update listAccToUpdate;
    }
}