import { LightningElement, api, track } from 'lwc'; 
export default class PromotionDropdownMenu extends LightningElement {
    @api currentPosition;
    @api selectedPromotion;   
    get promotionOptions() {
        const positions = [
            'Manager',
            'Team Lead',
            'Associate Developer',
            'Senior Developer',
            'Junior Developer',
            'Trainee'
        ];        
        const availablePromotions = positions.filter(position => {
            const currentPositionIndex = positions.indexOf(this.currentPosition);
            const positionIndex = positions.indexOf(position);
            return positionIndex < currentPositionIndex;
        });        
        return availablePromotions.map(promotion => {
            return { label: promotion, value: promotion };
        });
    } 
    handleChange(event) {
        this.selectedPromotion = event.detail.value;
        
        const promotionSelected = new CustomEvent('promotionselected', {
            detail: { selectedPromotion: this.selectedPromotion }
        });
        this.dispatchEvent(promotionSelected);
    }
}