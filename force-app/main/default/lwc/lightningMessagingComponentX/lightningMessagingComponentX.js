import { LightningElement, wire } from 'lwc';
import sampleChannel from '@salesforce/messageChannel/sampleMessageChannel__c';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';

export default class LightningMessagingComponentX extends LightningElement {
        messageFromA;

        @wire(MessageContext)
        context
        
        connectedCallback(){
            this.subscribeToMessageChannel()
        }

        subscribeToMessageChannel(){
            this.subscription = subscribe(this.context, sampleChannel, (message) => this.handleMessage(message), {scope: APPLICATION_SCOPE })
        }

        handleMessage(message){
            this.messageFromA = message.label.value;
        }
        unsubscribeToMessageChannel(){
            unsubscribe(this.subscription);
            this.subscription = null;
        }
}