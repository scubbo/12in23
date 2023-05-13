import ballerina/regex;

# Convert an integer to a Roman number.
#
# + number - the integer to convert
# + return - the Roman number as a string
function roman(int number) returns string {
    string asString = number.toString();
    int numDigits = asString.length();
    string outString = "";
    foreach [int, string] [idx, character] in regex:split(asString, "").enumerate() {
        outString += nextString(numDigits, idx, character);
    }
    return outString;
}

function nextString(int numDigits, int idx, string character) returns string {
    int place = numDigits - idx;
    int|error charAsInt = int:fromString(character);
    if charAsInt is error {
        panic error("Found non-integer character: " + character);
    }
    match place {
        4 => {
            string outString = "";       
            foreach int _ in int:range(0, charAsInt, 1) {
                outString += "M";
            }
            return outString;
        }
        3 => {
            return buildNextString("M", "D", "C", charAsInt);
        }
        2 => {
            return buildNextString("C", "L", "X", charAsInt);
        }
        1 => {
            return buildNextString("X", "V", "I", charAsInt);
        }
        _ => {
            panic error("number too large");
        }
    }
}

function buildNextString(string tenString, string fiveString, string oneString, int charAsInt) returns string {
    match charAsInt {
        9 => {
            return oneString + tenString;
        }
        8 => {
            return fiveString + oneString + oneString + oneString;
        }
        7 => {
            return fiveString + oneString + oneString;
        }
        6 => {
            return fiveString + oneString;
        }
        5 => {
            return fiveString;
        }
        4 => {
            return oneString + fiveString;
        }
        3 => {
            return oneString + oneString + oneString;
        }
        2 => {
            return oneString + oneString;
        }
        1 => {
            return oneString;
        }
        0 => {
            return "";
        }
        _ => {
            panic error("Unexpected int" + charAsInt.toString());
        }
    }
}
