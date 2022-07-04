import { LightningElement, wire } from 'lwc';
import getMonth from '@salesforce/apex/ContactMonthHandler.getMonth';

export default class ComboboxBasic extends LightningElement {
    value = '';

    @wire(getMonth, {dayOfMonth: '$value'})
    contacts

    get options() {
        return [
            { label: "Jan", value: "1" },
            { label: "Feb", value: "2" },
            { label: "March", value: "3" },
            { label: "April", value: "4" },
            { label: "May", value: "5" },
            { label: "June", value: "6" },
            { label: "July", value: "7" },
            { label: "Aug", value: "8" },
            { label: "Sept", value: "9" },
            { label: "Oct", value: "10" },
            { label: "Nov", value: "11" },
            { label: "Dec", value: "12" }
        ];
    }

    handleChange(event) {
        this.value = event.target.value;
        console.log('***********Value*************'+ this.value)
    }
    
}