import { LightningElement, wire, track, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getActiveEmployees from '@salesforce/apex/EmployeeController.getActiveEmployees';
import deleteEmployee from '@salesforce/apex/EmployeeController.deleteEmployee';

const COLUMNS = [
    {
        label: 'Name',
        fieldName: 'employeeDetailUrl',
        type: 'url',
        typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' },
        sortable: true
    },
    {
        label: 'Contact',
        fieldName: 'contactDetailUrl',
        type: 'url',
        typeAttributes: { label: { fieldName: 'contactName' }, target: '_blank' },
        sortable: true,
    },
    { label: 'Position', fieldName: 'Position__c', type: 'text', sortable: true },
    {
        label: 'Department',
        fieldName: 'departmentDetailUrl',
        type: 'url',
        typeAttributes: { label: { fieldName: 'departmentName' }, target: '_blank' },
        sortable: true,
    },
    { label: 'Employee Code', fieldName: 'Employee_Code__c', type: 'text', sortable: true },
    { label: 'Salary', fieldName: 'Salary__c', type: 'text', sortable: true },
    { label: 'Active', fieldName: 'Active__c', type: 'text', sortable: true },
    {
        type: 'action',
        typeAttributes: { rowActions: getRowActions }
    }
];

function getRowActions(row, doneCallback) {
    const actions = [
        { 'label': 'Edit', 'name': 'edit' },
        { 'label': 'Delete', 'name': 'delete' }
    ];
    doneCallback(actions);
}

export default class ActiveEmployees extends NavigationMixin(LightningElement) {
    @api recordId;
    @track employees = [];
    @track columns = COLUMNS;
    @track showForm = false;
    sortedBy;
    sortedDirection;
    wiredEmployeesResult;

    @wire(getActiveEmployees, { recordId: '$recordId' })
    wiredEmployees(result) {
        this.wiredEmployeesResult = result;
        const { data, error } = result;
        if (data) {
            this.employees = data.map(emp => ({
                ...emp,
                employeeDetailUrl: `/lightning/r/Employee__c/${emp.Id}/view`,
                contactDetailUrl: emp.Contact__c ? `/lightning/r/Contact/${emp.Contact__c}/view` : '',
                contactName: emp.Contact__r ? emp.Contact__r.Name : '',
                departmentDetailUrl: emp.Department__c ? `/lightning/r/Contact/${emp.Department__c}/view` : '',
                departmentName: emp.Department__r ? emp.Department__r.Name : ''
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.employees = undefined;
        }
    }

    handleRefresh() {
        return refreshApex(this.wiredEmployeesResult)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Employee data refreshed',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error refreshing data',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    handleAddEmployee() {
        this.showForm = true;
    }

    handleViewAll() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Department__c',  // Replace with the correct parent object API name
                relationshipApiName: 'Employees__r',   // Replace with the correct relationship API name
                actionName: 'view'
            }
        });
    }

    handleEmployeeCountClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Department__c',  // Replace with the correct parent object API name
                relationshipApiName: 'Employees__r',   // Replace with the correct relationship API name
                actionName: 'view'
            }
        });
    }

    handleSuccess() {
        this.showForm = false;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Employee added',
                variant: 'success'
            })
        );
        return refreshApex(this.wiredEmployeesResult);
    }

    handleError(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: event.detail.message,
                variant: 'error'
            })
        );
    }

    handleCancel() {
        this.showForm = false;
    }

    handleSaveEmployee() {
        this.template.querySelector('lightning-record-edit-form').submit();
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteEmployee(row);
                break;
            case 'edit':
                this.editEmployee(row);
                break;
            default:
        }
    }

    deleteEmployee(row) {
        deleteEmployee({ employeeId: row.Id })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Employee deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredEmployeesResult);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    editEmployee(row) {
        this.showForm = true;
        // Implement the logic to pre-populate the form fields with the employee data if required
    }

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.employees];
        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.employees = cloneData;
        this.sortedBy = sortedBy;
        this.sortedDirection = sortDirection;
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }
}