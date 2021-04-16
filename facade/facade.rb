class Scanner 
  def self.scan(source)
    source.split
  end
end

class Compiler
  def self.compile(input) 
    tokens = Scanner.scan(input)
    expression = Parser.new.parse(tokens)
    Generator.generate(expression)
  end
end


class Parser
  def initialize
    @expression_list = []
    @operand_list = []
  end

  def parse(tokens)
    tokens.each do |token|
      if isTokenExpression(token)
        @expression_list.push(token)
      elsif isTokenOperand(token)
        @operand_list.push(token)
      end
    end
    
    while !@expression_list.empty?
      current_expression = @expression_list.pop()
      
      expression_node = ExpressionNode.new()
      expression_node.operator = current_expression[0]

      right_operand = @operand_list.pop()
      right_operand_node = StatementNode.new()
      right_operand_node.value = right_operand.to_i

      left_operand = @operand_list.pop()
      left_operand_node = StatementNode.new()
      left_operand_node.value = left_operand.to_i

      expression_node.right = right_operand_node
      expression_node.left = left_operand_node
    end

    expression_node
  end

  def isTokenExpression(token) 
    token == "+"
  end
  
  def isTokenOperand(token) 
    token.match?(/[[:digit:]]/)
  end
end

class ExpressionNode
  attr_accessor :operator, :left, :right 
end

class StatementNode
  attr_accessor :value
end

class Generator
  def self.generate(expression)
    right_node = expression.right
    left_node = expression.left

    right_node.value + left_node.value
  end
end

result = Compiler.compile("100 + 1")
puts "Compiler result"
puts result