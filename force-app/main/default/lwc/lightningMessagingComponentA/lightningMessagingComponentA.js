import { LightningElement, wire } from 'lwc';
import sampleChannel from '@salesforce/messageChannel/sampleMessageChannel__c';
import {publish, MessageContext} from 'lightning/messageService';

export default class LightningMessagingComponentA extends LightningElement {
    inputMessage

    @wire(MessageContext)
    context

    inputHandler(event){
        this.inputMessage = event.target.value;
    }

    publishHandler(){
        const message = {
            label : {
                value : this.inputMessage
            } 
        }
        publish(this.context, sampleChannel, message);
    }
}