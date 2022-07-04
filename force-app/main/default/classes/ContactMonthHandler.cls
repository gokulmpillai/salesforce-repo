public with sharing class ContactMonthHandler {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getMonth(Integer dayOfMonth){
        List<Contact> conList = [SELECT FirstName, LastName, Email, JA_Gender__c, Birthdate FROM Contact WHERE Month_Number__c =: dayOfMonth];
        return conList;
    }    
}