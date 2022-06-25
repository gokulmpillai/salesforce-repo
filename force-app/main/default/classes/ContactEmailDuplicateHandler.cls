public class ContactEmailDuplicateHandler {
    public static void ContactEmailDuplicateCheckOnInsert(List <Contact> listOfNewContacts){
        Map<String, Contact> mapOfNewContacts = new Map<String, Contact>();
        
        //Iterate on the records being inserted and store the email in a map
        for(Contact con : listOfNewContacts){
            mapOfNewContacts.put(con.Email, con);
        }
        //Query the existing records with the exact email id with the record that is being created and add it in a list
        List<Contact> listOfExistingContacts = [SELECT Id, Name, Email 
                                                FROM Contact 
                                                WHERE Email IN :mapOfNewContacts.keySet()];
        
        //Iterate on the records being inserted and if any record with same email Id is found then thrown an error
        for(Contact conObj : listOfNewContacts){
            if(listOfExistingContacts.size()> 0 && conObj.Email != null){
                conObj.addError('Duplicate Email Found');
            }
        }
    }
    public static void ContactEmailDuplicateCheckOnUpdate(List <Contact> listOfContactsToUpdate, Map<Id, Contact> mapOfOldContacts){
        Map<String, Contact> mapOfNewContactsToUpdate = new Map<String, Contact>([SELECT Id, Name, Email FROM Contact]);
        
        //Iterate on the records being inserted and store the email in a map
        for(Contact conInstance  : listOfContactsToUpdate){
                mapOfNewContactsToUpdate.put(conInstance.Email, conInstance);
        }
        
        //Query the existing records with the exact email id with the record that is being created and add it in a list
        List<Contact> listOfExistingContacts = [SELECT Id, Name, Email 
                                                FROM Contact 
                                                WHERE Email IN :mapOfNewContactsToUpdate.keySet()];
        
        //Iterate on the records being inserted and if any record with same email Id is found then thrown an error              
        for(Contact conObj : listOfContactsToUpdate){
        //Check to find if the email id being updated is same as the current email id    
            if(conObj.Email != mapOfOldContacts.get(conObj.Id).Email)
            if(listOfExistingContacts.size()> 0){
                conObj.addError('Duplicate Email Found');
            }
        }
    }
}