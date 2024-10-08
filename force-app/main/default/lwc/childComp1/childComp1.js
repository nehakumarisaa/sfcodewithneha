import { LightningElement } from 'lwc';

export default class ChildComp1 extends LightningElement {

   handleChange(event) {
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name
        });
       this.dispatchEvent(selectEvent);
    }
}