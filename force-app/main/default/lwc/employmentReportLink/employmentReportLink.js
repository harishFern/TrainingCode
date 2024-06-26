import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class EmploymentReportLink extends NavigationMixin(LightningElement) {
    navigateToVisualforcePage() {
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/EmploymentReport'
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }
}