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
            {{These are escaped braces}}
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
        {These are escaped braces}
        """)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
