public function convert(int n) returns string {
    string outString = "";
    if (n % 3 == 0) {
        outString += "Pling";
    }
    if (n % 5 == 0) {
        outString += "Plang";
    } 
    if (n % 7 == 0) {
        outString += "Plong";
    }
    if (outString == "") {
        outString = n.toString();
    }
    return outString;
}
