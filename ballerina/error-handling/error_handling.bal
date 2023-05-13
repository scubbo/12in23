import ballerina/http;
import ballerina/io;

// Use the following endpoints to send HTTP GET request to get quotes

// This is an existing endpoint (which will be automatically spawned by the test framework)
final http:Client brainyQuoteClient = check new ("http://localhost:9095/brainyquote");

// This is a non-existing endpoint.
final http:Client legacyClient = check new ("http://localhost:6060/legacyquote");

public function main() returns error? {

    string|error resp = brainyQuoteClient->/();
    if resp is string {
        io:println(resp);
    } else {
        io:println(resp.message());
        return resp;
    }

    string|error resp1 = legacyClient->/();
    if resp1 is string {
        io:println(resp1);
    } else {
        io:println(resp1.message());
        return resp1;
    }

    return check legacyClient->/();

}
