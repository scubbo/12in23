import ballerina/regex;

# Returns the acronym of the given phrase.
#
# + phrase - a string
# + return - the acronym
function abbreviate(string phrase) returns string {

    string puncRemoved = regex:replaceAll(phrase, "[^a-zA-Z- ]", "");
    string puncRemovedTranslated = regex:replaceAll(puncRemoved, "[\\s-]+", " ");
    return regex:split(puncRemovedTranslated, "\\s").'map(function(string word) returns string => word.substring(0, 1).toUpperAscii()).reduce(function(string w1, string w2) returns string => string`${w1}${w2}`, "");
}
