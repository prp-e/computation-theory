require "./machine.rb"

Machine.new(
    EqualTo.new(
        Add.new(
            Variable.new(:a), Variable.new(:b)
        ),
        Variable.new(:c)
    ),
    {a: Number.new(5), b: Number.new(10), c: Number.new(13)}
).run