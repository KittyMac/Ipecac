## "Better than nothing" formatted strings for Swift

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

**An unbounded field** is defined by ```{0}``` with no spaces or other formatting.

**Field width** is defined by the space between the opening ```{``` and the closing ```}```. As you can see in the example above, this makes everything visually line up in the format string.

**Left justification** is defined by a ```-``` sign, such as ```{-0     }```. The sign can appear anywhere in the field, such as ```{  0  -  }```

**Center justification** is defined by a ```~``` sign, such as ```{~0     }``` The sign can appear anywhere in the field, such as ```{~    0  }```

**Right justification** is defined by a ```+``` sign, such as ```{+0     }``` The sign can appear anywhere in the field, such as ```{  0    +}```

**Unnamed value indexes** are allowed by using a ```?```.  This value starts at 0, and is incremented after every ```?``` encountered inside of a ```{}```. So ```"{???     }"``` is valid, you will get the ```2``` indexed value in this field.

***Type safety*** is preserved because ```String(ipecac:)``` and ```print(ipecac:)``` only accept values which adhere to ```CustomStringConvertible```. 

***Braces can still be used*** by escaping it with another brace; ```{{```. For consistency, ```}``` is also escaped by ```}```, so ```{{}}``` prints ```{}```

***Floating point precision*** is defined by placing ```.``` after the value index, followed by the number of precision digits. For example, ```{-?.4  }``` means "left aligned using the next value index with four points of decimal precision with a field width of 8"