## "Better than nothing" formatted strings for Swift

Think of Ipecac as an alternative for ```String(format:)```

**Example:**

```swift
print(ipecac: """
       {0}
       +----------+----------+----------+
       |{-??     }|{~?      }|{?       }|
       |{-?      }|{~?      }|{+?      }|
       |{-?.2    }|{~8.3    }|{+?.1    }|
       |{-1      }|{~2      }|{1       }|
       +----------+----------+----------+
       {{These are escaped braces}}
       """, "This is an unbounded field", "Hello", "World", 27, 1, 2, 3, 1.0/3.0, 543.0/23.0, 99999.99999)
```

**Output:**

```
This is an unbounded field
+----------+----------+----------+
|Hello     |  World   |        27|
|1         |    2     |         3|
|0.33      |  23.608  |      23.6|
|Hello     |  World   |     Hello|
+----------+----------+----------+
{These are escaped braces}
```

### Here's the skinny

Instead of ```%@``` or ```%s``` fields are denoted kind-of-like CSharp, with ```{0}``` denoting you want the 0 index value in this spot. That's where the similarity ends.

**An unbounded field**  
is defined by ```{0}``` with no spaces or other formatting.

**Field width**  
is defined by the amount of space between the opening ```{``` and the closing ```}```. As you can see in the example above, this makes everything visually line up in the format string.

**Left justification**  
is defined by a ```-``` sign, such as ```{-0     }```. The sign can appear anywhere in the field, such as ```{  0  -  }```

**Center justification**  
is defined by a ```~``` sign, such as ```{~0     }``` The sign can appear anywhere in the field, such as ```{~    0  }```

**Right justification**  
is defined by a ```+``` sign, such as ```{+0     }``` The sign can appear anywhere in the field, such as ```{  0    +}```

**Unnamed value indexes**  
are allowed by using a ```?```.  This value starts at 0, and is incremented after every ```?``` encountered inside of a ```{}```. So ```"{???     }"``` is valid, you will get the ```2``` indexed value in this field.

**Type safety**  
is preserved because ```String(ipecac:)``` and ```print(ipecac:)``` only accept values which adhere to ```CustomStringConvertible```. 

**Braces can still be used**  
by escaping it with another brace; ```{{```. For consistency, ```}``` is also escaped by ```}```, so ```{{}}``` prints ```{}```

**Floating point precision**  
is defined by placing ```.``` after the value index, followed by the number of precision digits. For example, ```{-?.4  }``` means "left aligned using the next value index with four points of decimal precision with a field width of 8"

## Installation

Ipecac is a fully compatible with the Swift Package Manager.

### Swift Package Manager

If you use swiftpm, you can add Ipecac as a dependency directly to your Package.swift file.

```
dependencies: [
    .package(url: "https://github.com/KittyMac/Ipecac.git", .upToNextMinor(from: "0.0.1")),
],
```

### Xcode

To integrate with Xcode, simply add it as a package dependency by going to

```
File -> Swift Packages -> Add Package Dependency
```

and pasting the url to this repository. Follow the instructions to complete the dependency addition.  [Check the releases page](https://github.com/KittyMac/ipecac/releases) for release versions or choose master branch for the bleeding edge.


## License

Flynn is free software distributed under the terms of the MIT license, reproduced below. Flynn may be used for any purpose, including commercial purposes, at absolutely no cost. No paperwork, no royalties, no GNU-like "copyleft" restrictions. Just download and enjoy.

Copyright (c) 2020 [Chimera Software, LLC](http://www.chimerasw.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.