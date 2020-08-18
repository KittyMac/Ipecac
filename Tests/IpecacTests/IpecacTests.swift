import XCTest
@testable import Ipecac

final class IpecacTests: XCTestCase {
    
    func testExample() {
        
        print(ipecac: """
                {0}
                +----------+----------+----------+
                |{-??     }|{~?      }|{?       }|
                |{-?      }|{~?      }|{+?      }|
                |{-1      }|{~2      }|{1       }|
                +----------+----------+----------+
                {{These are espaced braces}}
                """, "This is an unbounded field", "Hello", "World", 27, 1, 2, 3)
        
        let value = String(ipecac: """
            {0}
            +----------+----------+----------+
            |{-??     }|{~?      }|{?       }|
            |{-?      }|{~?      }|{+?      }|
            |{-1      }|{~2      }|{1       }|
            +----------+----------+----------+
            {{These are espaced braces}}
            """, "This is an unbounded field", "Hello", "World", 27, 1, 2, 3)
        print(value)
        
        XCTAssert(value == """
        This is an unbounded field
        +----------+----------+----------+
        |Hello     |  World   |        27|
        |1         |    2     |         3|
        |Hello     |  World   |     Hello|
        +----------+----------+----------+
        {These are espaced braces}
        """)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
