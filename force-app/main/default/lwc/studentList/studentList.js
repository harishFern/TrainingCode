import { LightningElement, api, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getStudents from '@salesforce/apex/StudentController.getStudents';


export default class StudentList extends LightningElement {
    @api recordId; // This is the Course record id
    @track students = []; // Initialize students array
    @track sortedBy;
    @track sortedDirection;
    @track isModalOpen = false;
    @track courseName; // Track the course name
    wiredStudentsResult;

    columns = [
        { label: 'No', fieldName: 'rowNumber', type: 'number', initialWidth: 60, cellAttributes: { alignment: 'left' } },
        { label: 'Name', fieldName: 'Name', sortable: true },
        { label: 'Roll No', fieldName: 'Roll_No__c', type: 'number', sortable: true, cellAttributes: { alignment: 'left' } },
        { label: 'Email', fieldName: 'Email__c', type: 'email', sortable: true },
        { label: 'Enrollment Date', fieldName: 'Enrollment_Date__c', type: 'date', sortable: true }
    ];

    @wire(getStudents, { courseId: '$recordId' })
    wiredStudents(result) {
        this.wiredStudentsResult = result;
        if (result.data) {
            // Add row numbers
            this.students = result.data.map((student, index) => {
                return { ...student, rowNumber: index + 1 };
            });
        } else if (result.error) {
            this.showToast('Error', result.error.body.message, 'error');
        }
    }

  

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.students];
        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.students = cloneData.map((student, index) => {
            return { ...student, rowNumber: index + 1 };
        });
        this.sortedBy = sortedBy;
        this.sortedDirection = sortDirection;
    }

    sortBy(field, reverse) {
        return (a, b) => {
            a = a[field] ? a[field] : '';
            b = b[field] ? b[field] : '';
            return reverse * ((a > b) - (b > a));
        };
    }

    handleRefresh() {
        return refreshApex(this.wiredStudentsResult);
    }

    handleNew() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleStudentCreate(event) {
        this.showToast('Success', 'Student created successfully', 'success');
        this.isModalOpen = false;
        return refreshApex(this.wiredStudentsResult);
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(evt);
    }

    get studentCount() {
        return this.students.length;
    }

    get cardTitle() {
        return `Students (${this.studentCount})`;
    }

   
}