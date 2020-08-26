
public func print(ipecac format: String, _ values: CustomStringConvertible...) {
    print(String(ipecac: format, values))
}

public extension String {
    
    private enum Alignment {
        case left
        case center
        case right
    }
    
    fileprivate init(ipecac format: String, _ values: [CustomStringConvertible]) {
        var scratch = ""
        scratch.reserveCapacity(format.count * 2)
        
        var bracesScratch = ""
        bracesScratch.reserveCapacity(format.count * 2)
        
        var inFormatter = false
        var inEscaped = false
        
        var variableIndex: Int = 0
        
        var beforePeriod = true
        var formatterPrecision: Int = 0
        var formatterHasIndex = false
        var formatterIndex: Int = 0
        var formatterIsUnbounded = true
        var formatterFieldWidth: Int = 0
        var formatterFieldAlignment: Alignment = .right
        
        let resetBraceStart = {
            inFormatter = true
            formatterHasIndex = false
            formatterIndex = 0
            formatterPrecision = 0
            formatterFieldWidth = 1
            formatterFieldAlignment = .right
            formatterIsUnbounded = true
            bracesScratch.removeAll(keepingCapacity: true)
            beforePeriod = true
        }
        
        for c in format {
            if inEscaped {
                inEscaped = false
                continue
            }
            if inFormatter {
                bracesScratch.append(c)
                
                formatterFieldWidth += 1
                if c == "}" {
                    inFormatter = false
                    if formatterHasIndex == false {
                        // We hit something like {  }, not a real formatter
                        inFormatter = false
                        scratch.append("{")
                        scratch.append(contentsOf: bracesScratch)
                        bracesScratch.removeAll(keepingCapacity: true)
                    } else if formatterIndex >= 0 && formatterIndex < values.count {
                        
                        let value = values[formatterIndex]
                        var valueString = value.description
                        
                        if beforePeriod == false && formatterPrecision >= 0 {
                            // assumably, value is a floating point "####.####". Since we
                            // only work with the string, confirm its a floating point
                            // and lop off the rest of the precision
                            var isFloatingPoint = true
                            var decimalCount = -1
                            var charCount = 0
                            for c in valueString {
                                switch c {
                                case ".":
                                    decimalCount = charCount
                                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                                    break
                                default:
                                    isFloatingPoint = false
                                    break
                                }
                                charCount += 1
                            }
                            
                            if isFloatingPoint && (decimalCount + formatterPrecision) < valueString.count {
                                valueString = String(valueString.prefix(decimalCount + formatterPrecision + 1))
                            }
                        }
                        
                        
                        if formatterIsUnbounded {
                            scratch.append(valueString)
                        } else {
                            let extra = formatterFieldWidth - valueString.count
                            if extra > 0 {
                                switch formatterFieldAlignment {
                                case .left:
                                    scratch.append(valueString)
                                    for _ in 0..<extra {
                                        scratch.append(" ")
                                    }
                                case .right:
                                    for _ in 0..<extra {
                                        scratch.append(" ")
                                    }
                                    scratch.append(valueString)
                                case .center:
                                    let leftPadding = extra / 2
                                    let rightPadding = extra - leftPadding
                                    for _ in 0..<leftPadding {
                                        scratch.append(" ")
                                    }
                                    scratch.append(valueString)
                                    for _ in 0..<rightPadding {
                                        scratch.append(" ")
                                    }
                                }
                            } else {
                                scratch.append(contentsOf: valueString.description.prefix(formatterFieldWidth))
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
                case ".":
                    beforePeriod = false
                case "?":
                    formatterHasIndex = true
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
                case "0":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 0
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 0
                    }
                case "1":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 1
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 1
                    }
                case "2":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 2
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 2
                    }
                case "3":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 3
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 3
                    }
                case "4":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 4
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 4
                    }
                case "5":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 5
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 5
                    }
                case "6":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 6
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 6
                    }
                case "7":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 7
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 7
                    }
                case "8":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 8
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 8
                    }
                case "9":
                    formatterHasIndex = true
                    if beforePeriod {
                        formatterIndex = (formatterIndex * 10) + 9
                    } else {
                        formatterPrecision = (formatterPrecision * 10) + 9
                    }
                case " ", "\n", "\r", "\t":
                    formatterIsUnbounded = false
                case "{":
                    // we encountered a "{   {" type deal. This could be a valid brace inside
                    // a brace to be ignored.  So we invalidate the outer brace, and start
                    // tracking the inner one as if it were real
                    bracesScratch.removeLast()
                    scratch.append("{")
                    scratch.append(contentsOf: bracesScratch)
                    bracesScratch.removeAll(keepingCapacity: true)
                    
                    resetBraceStart()
                    break
                default:
                    inFormatter = false
                    scratch.append("{")
                    scratch.append(contentsOf: bracesScratch)
                    bracesScratch.removeAll(keepingCapacity: true)
                    break
                }
                
            } else {
                if c == "\\" {
                    inEscaped = true
                    continue
                }
                if c == "{" {
                    resetBraceStart()
                    continue
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
