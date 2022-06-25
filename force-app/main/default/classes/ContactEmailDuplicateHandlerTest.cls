@isTest
public class ContactEmailDuplicateHandlerTest {
    @testSetup static void setup(){
        List<Contact> testContacts = new List<Contact>();
        for(Integer i=0;i<2;i++) {
            testContacts.add(new Contact(LastName = 'TestAcct'+i, Email = 'test@mailinator.com' ));
        }
        
        insert testContacts;  
    }
    @isTest
    public static void DuplicateContactTest(){
        List<Contact> conList = [SELECT Id, LastName, Email FROM Contact];
        System.assertNotEquals(1, conList.size(), 'Duplicate Email Found');
        
        List<Contact> conToUpdate = new List<Contact>();
        for(Contact conObj : conList){
            conObj.Email = 'test@mailinator.com';
            conToUpdate.add(conObj);
        }
        try{
            update conToUpdate;
        }
        catch(Exception e){
            System.assert(e.getMessage().contains('Duplicate Email Found'));
        }
    }
}