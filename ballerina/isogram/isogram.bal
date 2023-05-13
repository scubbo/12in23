import ballerina/regex;

public function isIsogram(string sentence) returns boolean {
    if sentence.length() == 0 {
        return true;
    }
    string[] lettersSeen = [];
    foreach string char in regex:split(
        regex:replaceAll(sentence, "[ -]", ""),
        ""
    ) {
        string c = char.toLowerAscii();
        if (lettersSeen.indexOf(c) == ()) {
            lettersSeen.push(c);
        } else {
            return false;
        }
    }
    return true;
}
