### The "better than nothing" formatted strings for Swift

**Example:**

```swift
print(ipecac: """
         {0}
         +----------+----------+----------+
         |{-??     }|{~?      }|{?       }|
         |{-?      }|{~?      }|{+?      }|
         |{-1      }|{~2      }|{1       }|
         +----------+----------+----------+
         {{These are espaced braces}}
         """, "This is an unbounded field", "Hello", "World", 27, 1, 2, 3)
```

**Output:**

```swift
This is an unbounded field
+----------+----------+----------+
|Hello     |  World   |        27|
|1         |    2     |         3|
|Hello     |  World   |     Hello|
+----------+----------+----------+
{These are espaced braces}
```

### Here's the skinny

Instead of ```%@``` or ```%s``` fields are denoted kind-of-like CSharp, with ```{0}``` denoting you want the 0 index value in this spot. That's where the similarity ends.

**An unbounded field** is defined by ```{0}``` with no spaces or other formatting.

**Field width** is defined by the space between the opening ```{``` and the closing ```}```. As you can see in the example above, this makes everything visually line up in the format string.

**Left justification** is defined by a ```-``` sign, such as ```{-0     }```. The sign can appear anywhere in the field, such as ```{  0  -  }```

**Center justification** is defined by a ```~``` sign, such as ```{~0     }``` The sign can appear anywhere in the field, such as ```{~    0  }```

**Right justification** is defined by a ```+``` sign, such as ```{+0     }``` The sign can appear anywhere in the field, such as ```{  0    +}```

**Unnamed value indexes** are allowed by using a ```?```.  This value starts at 0, and is incremented after every ```?``` encountered inside of a ```{}```. So ```"{???     }"``` is valid, you will get the ```2``` indexed value in this field.

***Type safety*** is preserved because ```String(ipecac:)``` and ```print(ipecac:)``` only accepts values which adhere to ```CustomStringConvertible```. 

***Braces can still be used*** by escaping it with another brace; ```{{```. For consistency, ```}``` is also escaped by ```}```, so ```{{}}``` prints ```{}```



### What's on the TODO list

Individual value formatting, such the precision for float values.