import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/RetrieveContacts.getContactList';

export default class ContactLightningDataTable extends LightningElement {
    

 columns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone', type: 'Phone' },
    { label: 'Email', fieldName: 'Email', type:'Email' }
];

@wire(getContacts)
contacts

}