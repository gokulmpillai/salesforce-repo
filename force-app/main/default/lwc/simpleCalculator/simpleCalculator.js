import { LightningElement } from 'lwc';

export default class SimpleCalculator extends LightningElement {

    firstNumber;
    secondNumber;
    result;

    firstNumberHandler(event){
        this.firstNumber = event.target.value;
    }
    secondNumberHandler(event){
        this.secondNumber = event.target.value;
    }
    additionHandler(event){
        this.result = event.target.value;
        this.result = parseInt(this.firstNumber) + parseInt(this.secondNumber);
        console.log('Addition:'+ this.result);
    }
    subtractionHandler(event){
        this.result = this.firstNumber - this.secondNumber;
        console.log('Subtraction:'+ this.result);
    }
    multiplicationHandler(event){
        this.result = this.firstNumber * this.secondNumber;
        console.log('Multiplication:'+ this.result);
    }
    divisionHandler(event){
        this.result = this.firstNumber / this.secondNumber;
        console.log('Division:'+ this.result);
    }

}