import ballerina/http;

# Add the necessary attributes to this record to accept two operands and an operator.
#
# + operand1 - Is a float used as the first operand in an equation
# + operand2 - Is a float used as the second operand in an equation
# + operator - Is a string that represents the operator
public type Calculation record {|
    float operand1;
    float operand2;
    string operator;
|};

# Add the necessary attributes to this record to include the result value and the expression.
#
# + result - The result of the operation
# + expression - The evaluated expression that used to calculate the result
public type Response record {|
    float result;
    string expression;
|};

service / on new http:Listener(9090) {

    // Add HTTP resource function to accept a POST request on path '/calc'
    // The function should accept the above Calculation record as the payload and return a generic json object
    resource function post calc(Calculation calc) returns Response {

        match calc.operator {
            // A properly "Enterprise-scale" solution here would match to return a tuple of `func(float, float) returns float` and `string`
            // to then use in constructing the return Record, but Ain't Nobody Got Time For That
            // (especially since I can't immediately figure out how to declare an uninitialized variable outside the scope of the match)
            "+" => {
                return {result: calc.operand1 + calc.operand2, expression: string `${calc.operand1}+${calc.operand2}`};
            }
            "-" => {
                return {result: calc.operand1 - calc.operand2, expression: string `${calc.operand1}-${calc.operand2}`};
            }
            "*" => {
                return {result: calc.operand1 * calc.operand2, expression: string `${calc.operand1}*${calc.operand2}`};
            }
            "/" => {
                return {result: calc.operand1 / calc.operand2, expression: string `${calc.operand1}/${calc.operand2}`};
            }
            _ => {
                return {result: 0, expression: string `${calc.operand1}${calc.operator}${calc.operand2}`};
            }
        }
    }
}
