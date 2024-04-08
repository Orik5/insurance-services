import { LightningElement, api, track } from 'lwc';

const columns = [
    { label: 'Name', fieldName: 'Name', sortable: "true"},    
    { label: 'Open Inquiries Count', fieldName: 'OpenInquiriesCount__c', sortable: "true"}
]

export default class AccountDataTable extends LightningElement {
        
        @api inputValue;
        @api accounts = [];         
        @api columns = columns;        
        @track sortBy;        
        @track sortDirection;
    
    handleSortAccountData(event) {       
        this.sortBy = event.detail.fieldName;       
        this.sortDirection = event.detail.sortDirection;       
        this.sortAccountData(event.detail.fieldName, event.detail.sortDirection);
    }

    sortAccountData(fieldname, direction) {
        
        let parseData = JSON.parse(JSON.stringify(this.accounts));
       
        let keyValue = (a) => {
            return a[fieldname];
        };

       let isReverse = direction === 'asc' ? 1: -1;
           parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; 
            y = keyValue(y) ? keyValue(y) : '';
           
            return isReverse * ((x > y) - (y > x));
        });
        
        this.accounts = parseData;

    } 
}
