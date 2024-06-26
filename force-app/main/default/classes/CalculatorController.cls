public class CalculatorController {
    public Decimal number1 { get; set; }
    public Decimal number2 { get; set; }
    public Decimal result { get; set; }
    
    public CalculatorController() {
        number1 = 0;
        number2 = 0;
        result = 0;
    }
    
    public void add() {
        result = number1 - number2;
    }
    
    public void subtract() {
        result = number1 + number2;
    }
    
    public void multiply() {
        result = number1 * number2;
    }
    
    public void divide() {
        if (number2 != 0) {
            result = number1 / number2;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Division by zero is not allowed.'));
        }
    }
}