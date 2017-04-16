class Variable < Struct.new(:name)
    def to_s
        name.to_s
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        true
    end
    def reduce(environment)
        environment[name]
    end
end 

class Number < Struct.new(:value)
    def to_s
        value.to_s 
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        false
    end
end

class Boolean < Struct.new(:value)
    def to_s
        value.to_s
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        false
    end
end

class Add < Struct.new(:left, :right)
    def to_s 
        "(+ #{left}  #{right})"
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        true
    end
    def reduce(environment)
        if left.reducible?
            Add.new(left.reduce(environment), right)
        elsif right.reducible?
            Add.new(left, right.reduce(environment))
        else
            Number.new(left.value + right.value)
        end
    end
end

class Subtract < Struct.new(:left, :right)
    def to_s
        "(- #{left}  #{right})"
    end 
    def inspect
        "<#{self}>"
    end 
    def reducible?
        true 
    end
    def reduce(environment)
        if left.reducible?
            Subtract.new(left.reduce(environment), right)
        elsif right.reducible?
            Subtract.new(left, right.reduce(environment))
        else
            Number.new(left.value - right.value)
        end
    end
end

class Multiply < Struct.new(:left, :right)
    def to_s 
        "(* #{left}  #{right})"
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        true
    end
    def reduce(environment)
        if left.reducible?
            Multiply.new(left.reduce(environment), right)
        elsif right.reducible?
            Multiply.new(left, right.reduce(environment))
        else
            Number.new(left.value * right.value)
        end
    end
end

class Divide < Struct.new(:left, :right)
    def to_s
        "(/ #{left}  #{right})"
    end 
    def inspect 
        "<#{self}>"
    end 
    def reducible?
        true 
    end 
    def reduce(environment)
        if left.reducible?
            Divide.new(left.reduce(environment), right)
        elsif right.reducible?
            Divide.new(left, right.reduce(environment))
        else 
            Number.new(left.value / right.value)
        end
    end
end

class Remainder < Struct.new(:left, :right)
    def to_s
        "(% #{left} #{right})"
    end 
    def inspect
        "<#{self}>"
    end
    def reducible?
        true 
    end 
    def reduce(environment)
        if left.reducible?
            Remainder.new(left.reduce(environment), right)
        elsif right.reducible?
            Remainder.new(left, right.reduce(environment))
        else 
            Number.new(left.value % right.value)
        end 
    end
end

class Power < Struct.new(:left, :right)
    def to_s
        "(^ #{left} #{right})"
    end
    def inspect
        "<#{self}>"
    end 
    def reducible?
        true 
    end 
    def reduce(environment)
        if left.reducible?
            Power.new(left.reduce(environment), right)
        elsif right.reducible?
            Power.new(left, right.reduce(environment))
        else 
            Number.new(left.value ** right.value)
        end 
    end
end

class LessThan < Struct.new(:left, :right)
    def to_s
        "(< #{left}  #{right})"
    end
    def inspect 
        "<#{self}>"
    end 
    def reducible?
        true 
    end 
    def reduce(environment)
        if left.reducible?
            LessThan.new(left.reduce(environment), right)
        elsif right.reducible?
            LessThan.new(left, right.reduce(environment))
        else
            Boolean.new(left.value < right.value)
        end
    end
end 

class GreaterThan < Struct.new(:left, :right)
    def to_s
        "(> #{left}  #{right})"
    end 
    def inspect
        "<#{self}>"
    end
    def reducible?
        true
    end
    def reduce(environment)
        if left.reducible?
            GreaterThan.new(left.reduce(environment), right)
        elsif right.reducible?
            GreaterThan.new(left, right.reduce(environment))
        else 
            Boolean.new(left.value > right.value)
        end
    end
end

class EqualTo < Struct.new(:left, :right)
    def to_s
        "(= #{left}  #{right})"
    end
    def inspect
        "<#{self}>"
    end
    def reducible?
        true
    end 
    def reduce(environment)
        if left.reducible?
            EqualTo.new(left.reduce(environment), right)
        elsif right.reducible?
            EqualTo.new(left, right.reduce(environment))
        else 
            Boolean.new(left.value == right.value)
        end
    end
end

class BitwiseNOT < Struct.new(:right)
    def to_s 
        "(not #{right})"
    end 
    def inspect
        "<#{self}>"
    end 
    def reducible?
        true 
    end 
    def reduce(environment)
        if right.reducible?
            BitwiseNOT.new(right.reduce(environment))
        else 
            Number.new(~right.value)
        end 
    end
end


class Machine < Struct.new(:expression, :environment)
    def step
        self.expression = expression.reduce(environment) 
    end
    def run 
        while expression.reducible?
            puts expression
            step 
        end
        puts expression
    end
end