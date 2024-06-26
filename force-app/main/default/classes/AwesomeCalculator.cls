public class AwesomeCalculator {
        public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        system.debug(calculator.doAdd(x,y));
        return calculator.doAdd(x,y);
    }
}