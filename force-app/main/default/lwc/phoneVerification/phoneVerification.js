import { LightningElement } from 'lwc';
import getPhoneDetails from '@salesforce/apex/VeriphoneIntegration.phoneNumberVerification';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PhoneVerification extends LightningElement {
    
    phoneNumber;
    details={};
    invalid=false;
    
    phoneNumberHandler(event){
        this.phoneNumber = event.target.value; 
    }
    phoneDetailsHandler(){
        getPhoneDetails({phoneNumber : this.phoneNumber}).then(response => 
            {
                if(response.phone_valid == true){
                this.details = {
                    phone: response.phone,
                    status: response.status,
                    country : response.country,
                    carrier : response.carrier,
                    valid : response.phone_valid,
                    type : response.phone_type,
                    region : response.phone_region,
                    local : response.local_number,
                    countryCode: response.country_code,
                    internationalNumber: response.international_number 
                    };
                    this.invalid=false;
                    console.log('Response: ' + JSON.stringify(response));
                    console.log(this.details);
                    }
                    else{
                        this.showToast();
                        this.invalid=true;
                        this.details=false;
                    }          
        }).catch(error => {
            console.log('Error:'+ JSON.stringify(error));
        })
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Error',
            message:'Entered Number is Invalid',
            variant:'error'    
        });
        this.dispatchEvent(event);
    }
}