import XCTest
@testable import Ipecac

final class IpecacTests: XCTestCase {
    
    func testExample() {
        
        let value = String(ipecac: """
            {0}
            +----------+----------+----------+
            |{-??     }|{~?      }|{?       }|
            |{-?      }|{~?      }|{+?      }|
            |{-?.2    }|{~8.3    }|{+?.1    }|
            |{-1      }|{~2      }|{1       }|
            +----------+----------+----------+
            {{we no longer escape braces}}
            {These don't need to be escaped because they contain invalid characters}
            """, "This is an unbounded field", "Hello", "World", 27, 1, 2, 3, 1.0/3.0, 543.0/23.0, 99999.99999)
        print(value)
        
        XCTAssert(value == """
        This is an unbounded field
        +----------+----------+----------+
        |Hello     |  World   |        27|
        |1         |    2     |         3|
        |0.33      |  23.608  |      23.6|
        |Hello     |  World   |     Hello|
        +----------+----------+----------+
        {{we no longer escape braces}}
        {These don't need to be escaped because they contain invalid characters}
        """)
    }
    
    func testExample2() {
        
        let value = String(ipecac: """
            function {?} {
                if true {
                    print("Hello World")
                }
            }
            """, "printHelloWorld")
        print(value)
        
        XCTAssert(value == """
        function printHelloWorld {
            if true {
                print("Hello World")
            }
        }
        """)
    }

    static var allTests = [
        ("testExample", testExample),
        ("testExample2", testExample2),
    ]
}
