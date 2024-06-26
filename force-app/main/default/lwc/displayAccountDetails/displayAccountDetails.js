import{LightningElement, api, track, wire} from 'lwc';
import getAccountList from '@salesforce/apex/AccountCardHelper.getAccountList';
export default class LightningCardLWC extends LightningElement{
    @api recordId;
    @track AccountName;
    @track AccountPhone;
    @track AccountWebsite;
    @track AccountAnnualRevenue;
    @track error;
    @wire(getAccountList, {recordId:'$recordId'})
    wiredAccount({data,error}){
        if(data){
            this.Account=data[0];
            this.AccountName=data[0].Name;
            this.AccountPhone=data[0].Phone;
            this.AccountWebsite=data[0].Website;
            this.AccountAnnualRevenue=data[0].AnnualRevenue;
            console.log(JSON.stringify(this.Account));
            console.log(JSON.stringify(data));
        }
        else if(error){
            this.error=error;
        }
    }
}