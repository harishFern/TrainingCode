import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getStudents from '@salesforce/apex/CourseController.getStudents';

export default class CourseStudentsList extends LightningElement {
    @api recordId;  // Course record Id
    @track students;
    @track sortedBy;
    @track sortedDirection = 'asc';
    @track isModalOpen = false;
    @track courseId;

    @wire(getStudents, { courseId: '$recordId' })
    wiredStudents(result) {
        this.wiredResult = result;
        if (result.data) {
            this.students = result.data;
        } else if (result.error) {
            // handle error
        }
    }

    get studentCount() {
        return this.students ? this.students.length : 0;
    }

    columns = [
        { label: 'Name', fieldName: 'Name', sortable: true },
        { label: 'Roll No', fieldName: 'Roll_No__c', sortable: true },
        { label: 'Email', fieldName: 'Email__c', sortable: true },
        { label: 'Enrollment Date', fieldName: 'Enrollment_Date__c', sortable: true },
    ];

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.students];
        cloneData.sort((a, b) => {
            const aValue = a[sortedBy] ? a[sortedBy].toLowerCase() : '';
            const bValue = b[sortedBy] ? b[sortedBy].toLowerCase() : '';
            return sortDirection === 'asc' ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue);
        });
        this.students = cloneData;
        this.sortedBy = sortedBy;
        this.sortedDirection = sortDirection;
    }

    handleNewClick() {
        this.isModalOpen = true;
        this.courseId = this.recordId;
    }

    handleCloseModal() {
        this.isModalOpen = false;
    }

    handleStudentCreated() {
        this.isModalOpen = false;
        return refreshApex(this.wiredResult);
    }

    handleRefresh() {
        return refreshApex(this.wiredResult);
    }
}