# Computation Theory Practice 

Just a very simple compiler, written in ruby. I made this to understand theory of computation and 
theory of machines and languages. 

## How can we use the backend? 
As I didn't write any parser for this, you can use this machine like this : 

```ruby 
require './machine.rb'

Machine.new(
    EqualTo.new(
        Add.new(
            Variable.new(:a), Variable.new(:b)
        ),
        Variable.new(:c)
    ),
    {a: Number.new(5), b: Number.new(10), c: Number.new(13)}
).run 
```
also available in `example.rb` file. This is the result :

```
(= (+ a  b)  c)
(= (+ 5  b)  c)
(= (+ 5  10)  c)
(= 15  c)
(= 15  13)
false
```