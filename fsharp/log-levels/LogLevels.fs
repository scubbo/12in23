module LogLevels

let message (logLine: string): string =
    let indexOfColon = logLine.IndexOf ':'
    logLine.Substring(indexOfColon+2).Trim()

let logLevel(logLine: string): string =
    // In real life I'd do this with a regex!
    let indexOfCloseSquareBracket = logLine.IndexOf ']'
    // -1 because Substring takes length, not endIndex
    logLine.Substring(1, indexOfCloseSquareBracket-1).ToLower()

let reformat(logLine: string): string =
    // And this is why I dislike languages with paren-optional functions!
    sprintf "%s (%s)" (message logLine) (logLevel logLine)
