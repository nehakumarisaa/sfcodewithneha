import { LightningElement, track } from 'lwc';

export default class lwcSingleSelMultiSelPopover extends LightningElement {

    @track contactList = "[{\"id\":\"01\",\"name\":\"Anne Frank\"},{\"id\":\"02\",\"name\":\"Janet Joe\"},{\"id\":\"03\",\"name\":\"Sarah Morgan\"},{\"id\":\"04\",\"name\":\"Tamara Davis\"}]";
    @track isMultiSelect = null;
    @track showModal;
    @track showSingleLabel = false;
    @track showMultiLabel = false;
    @track label = 'You have Selected: {0} who is {1}';
    @track singleValue = [];
    @track multiValue = [];
    opts=[];
    selectedValues;
    selectedContact;

    get options() {
        return [
            { label: 'Member - Single Select Response', value: 'SingleValue' },
            { label: 'Member - Multi Select Response', value: 'MultipleValue' }
        ];
    }

    get contactOptions() {
        return [
            { label: 'A Client User', value: 'a Client User' },
            { label: 'A Navigator', value: 'a Navigator' },
            { label: 'An Admin', value: 'an Admin' }
        ];
    }

    get contacts() {
        return JSON.parse(this.contactList);
    }

    openModal() {
        this.value = '';
        this.selectedValues = '';
        this.selectedContact = '';
        this.isMultiSelect = null;
        this.showModal = true;
    }

    closeModal() {
        this.showModal = false;
    }

    get showSelectOptions() {
        let showSelect = false;
        if(this.isMultiSelect !== null){
            showSelect = true;
        }
        return showSelect;
    }

    changeSelection(event) {
        this.opts=[];
        let selectedValue = event.detail.value;
        if(selectedValue === 'SingleValue'){
            this.isMultiSelect = false;
        } else if(selectedValue === 'MultipleValue'){
            this.isMultiSelect = true;
        }
    }

    openAccordian() {
        return (this.isMultiSelect || !this.isMultiSelect);
    }

    singleOptionSelection(event) {
        let selectedId = event.currentTarget.dataset.id;
        let count = 0;
        this.singleValue.forEach(i =>{ 
            if(i.id === selectedId){
                this.singleValue.splice(count,1);
            }
            count++;
        })
        this.selectedValues = event.detail.value;
        this.selectedContact = event.currentTarget.dataset.value;
        let newValue = this.label.replace('{1}', this.selectedValues);
        newValue = newValue.replace('{0}', this.selectedContact);
        let item = {
            id: selectedId,
            value: newValue
        };
        this.opts.push(item);
    }

    multiOptionSelection(event) {
        let selectedId = event.currentTarget.dataset.id;
        this.selectedContact = event.currentTarget.dataset.value;
        this.selectedValues = event.detail.value.join(',');
        let newValue = this.label.replace('{1}', this.selectedValues);
        newValue = newValue.replace('{0}', this.selectedContact);
        let item = {
            id: selectedId,
            value: newValue
        };
        this.opts.push(item);
    }

    SubmitResponce() {
        this.showModal = false;
        if(this.isMultiSelect) {
            this.opts.forEach(item =>{
                this.multiValue.push(item)
            });
            this.multiValue.forEach(item =>{
                this.multiValue.splice(this.multiValue.findIndex(x => x.id === item.id),1);
            });
            this.showMultiLabel = true;
        }
        if(!this.isMultiSelect) {
            this.opts.forEach(item =>{
                this.singleValue.push(item)
            });
            this.showSingleLabel = true;
        }
    }
}