public class VeriphoneIntegration {
    @AuraEnabled
    public static VeriphoneWrapper phoneNumberVerification(String phoneNumber){
        String apiKey = [SELECT Id, API_Key__c FROM Veriphone_API_Key__mdt].API_Key__c;
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.veriphone.io/v2/verify?phone='+ phoneNumber +'&key=' + apiKey);
        request.setMethod('GET');
        HttpResponse response = h.send(request);
        VeriphoneWrapper wrapper = (VeriphoneWrapper)JSON.deserialize(response.getBody(), VeriphoneWrapper.class);
        System.debug('response:' + wrapper);
        return wrapper;
    }
    public class VeriphoneWrapper{
        @AuraEnabled
        public String status{get; set;}
        @AuraEnabled
        public String phone{get; set;}
        @AuraEnabled
        public Boolean phone_valid{get; set;}
        @AuraEnabled
        public String phone_type{get; set;}
        @AuraEnabled
        public String phone_region{get; set;}
        @AuraEnabled
        public String country{get; set;}
        @AuraEnabled
        public String country_code{get; set;}
        @AuraEnabled
        public String international_number{get; set;}
        @AuraEnabled
        public String local_number{get; set;}
        @AuraEnabled
        public String e164{get; set;}
        @AuraEnabled
        public String carrier{get; set;}      
    }
}