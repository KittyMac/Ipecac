
func print(ipecac format: String, _ values: CustomStringConvertible...) {
    print(String(ipecac: format, values))
}

extension String {
    
    private enum Alignment {
        case left
        case center
        case right
    }
    
    fileprivate init(ipecac format: String, _ values: [CustomStringConvertible]) {
        var scratch = ""
        scratch.reserveCapacity(format.count * 2)
        
        var inFormatter = false
        var inEscaped = false
        var isClosingBrace = false
        
        var variableIndex: Int = 0
        
        var formatterIndex: Int = 0
        var formatterIsUnbounded = true
        var formatterFieldWidth: Int = 0
        var formatterFieldAlignment: Alignment = .right
        
        for c in format {
            if inEscaped {
                inEscaped = false
                continue
            }
            if inFormatter {
                formatterFieldWidth += 1
                if c == "{" && formatterFieldWidth == 2 {
                    scratch.append("{")
                    inFormatter = false
                    continue
                }
                if c == "}" {
                    inFormatter = false
                    if formatterIndex >= 0 && formatterIndex < values.count {
                        let value = values[formatterIndex].description
                        if formatterIsUnbounded {
                            scratch.append(value)
                        } else {
                            let extra = formatterFieldWidth - value.count
                            if extra > 0 {
                                switch formatterFieldAlignment {
                                case .left:
                                    scratch.append(value)
                                    for _ in 0..<extra {
                                        scratch.append(" ")
                                    }
                                case .right:
                                    for _ in 0..<extra {
                                        scratch.append(" ")
                                    }
                                    scratch.append(value)
                                case .center:
                                    let leftPadding = extra / 2
                                    let rightPadding = extra - leftPadding
                                    for _ in 0..<leftPadding {
                                        scratch.append(" ")
                                    }
                                    scratch.append(value)
                                    for _ in 0..<rightPadding {
                                        scratch.append(" ")
                                    }
                                }
                            } else {
                                scratch.append(contentsOf: value.description.prefix(formatterFieldWidth))
                            }
                        }
                    } else if formatterIsUnbounded == false {
                        for _ in 0..<formatterFieldWidth {
                            scratch.append(" ")
                        }
                    }
                    continue
                }
                
                switch c {
                case "?":
                    formatterIndex = variableIndex
                    variableIndex += 1
                case "-":
                    formatterFieldAlignment = .left
                    formatterIsUnbounded = false
                case "~":
                    formatterFieldAlignment = .center
                    formatterIsUnbounded = false
                case "+":
                    formatterFieldAlignment = .right
                    formatterIsUnbounded = false
                case "0": formatterIndex = (formatterIndex * 10) + 0
                case "1": formatterIndex = (formatterIndex * 10) + 1
                case "2": formatterIndex = (formatterIndex * 10) + 2
                case "3": formatterIndex = (formatterIndex * 10) + 3
                case "4": formatterIndex = (formatterIndex * 10) + 4
                case "5": formatterIndex = (formatterIndex * 10) + 5
                case "6": formatterIndex = (formatterIndex * 10) + 6
                case "7": formatterIndex = (formatterIndex * 10) + 7
                case "8": formatterIndex = (formatterIndex * 10) + 8
                case "9": formatterIndex = (formatterIndex * 10) + 9
                default:
                    formatterIsUnbounded = false
                    break
                }
                
            } else {
                if c == "\\" {
                    inEscaped = true
                    continue
                }
                if c == "{" {
                    inFormatter = true
                    formatterIndex = 0
                    formatterFieldWidth = 1
                    formatterFieldAlignment = .right
                    formatterIsUnbounded = true
                    continue
                }
                if c == "}" {
                    if isClosingBrace == true {
                        isClosingBrace = false
                        continue
                    }
                    isClosingBrace = true
                } else {
                    isClosingBrace = false
                }
                
                scratch.append(c)
            }
        }
        
        self.init(scratch)
    }
    
    init(ipecac format: String, _ values: CustomStringConvertible...) {
        self.init(ipecac: format, values)
    }
}
