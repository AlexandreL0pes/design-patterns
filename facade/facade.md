# Facade

### Resumo

Definir uma interface comum para diversos subsistemas, tornando o sistema mais fácil de ser usado.

## Objetivo

Esse padrão de projeto promove a minimização de comunicação e de dependências entre subsistemas, portanto, o objeto `Façade`afornece uma interface única e simplificada para os recursos e facilidades comuns dentro do sistema.

### Implementação

O padrão é composto por dois componentes, sendo eles: o `Facade` possuindo a função de delegar as solicitações aos devidos subsistemas. O outro componente do padrão refere-se as demais classes que serão referenciadas pelo `Facade` e por isso, tem de implementar a funcionalidade do subsistema.

### Exemplo

O código completo está no seguinte arquivo.

Nesse exemplo utilizaremos o contexto de compiladores e para facilitar o processo, será implementado o padrão `facade`.

O subsistema do compilador tem diversas classes, a primeira delas trata-se da `Scanner`que aceita uma string de caracteres e produz uma lista de tokens a partir da lista.

```ruby
class Scanner 
  def self.scan(source)
    source.split
  end
end
```

A classe `Parser` obtêm a lista de tokens e monta uma árvore de análise a partir dos `tokens` de `Scanner`.

```ruby
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
      right_operand_node = OperandNode.new()
      right_operand_node.value = right_operand.to_i

      left_operand = @operand_list.pop()
      left_operand_node = OperandNode.new()
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
```

Para representar os nós dentro da árvore, temos as classes `ExpressionNode` e `StatementNode`

```ruby
class ExpressionNode
  attr_accessor :operator, :left, :right 
end

class StatementNode
  attr_accessor :value
end
```

Tais classes apresentadas compõe o subsistema compilador, e então implementamos a classe `Compiler`, uma facade que junta todas as peças.

```ruby
class Compiler
  def self.compile(input) 
    tokens = Scanner.scan(input)
    expression = Parser.new.parse(tokens)
    Generator.generate(expression)
  end
end
```

### Consequências

- Isola os clientes dos componentes dos sistemas;
- Promove um acoplamento fraco;
- Redução das dependências de compilação