# Composite

### Resumo
  Adiciona responsabilidades dinamicamente em objetos individuais e não em toda a classe.

### Objetivo
  Este padrão consiste na criação de um novo objeto, chamado de Decorator, que irá englobar o objeto inicial, o qual deseja-se adicionar novas responsabilidades de forma flexível.

### Implementação
O padrão é composto por `Component`, `ConcreteComponent`, `Decorator` e `ConcreteDecorator`. O primeiro deles, `Component` define a interface comum para que os objetos possam ter as responsabilidades acrescentadas dinamicamente. 

Em seguida, o `ConcreteComponent` consiste na definição de um objeto que poderá ter responsabilidades atribuídas.

A classe `Decorator` cria uma nova interface para os demais `Decorator`, com base na interface `Component`.

A classe `ConcreteDecorator` herda da classe `Decorator` e tem a responsabilidade de acrescentar responsabilidades ao `ConcreteComponent`.


### Exemplo

O código completo está no seguinte [arquivo](decorator.rb).

Usando o exemplo abaixo, disponível no [link](https://refactoring.guru/pt-br/design-patterns/decorator/), temos o contexto de uma aplicação que integra com outros serviços como o Slack, Facebook e Mensagens. 

![Estrutura](https://refactoring.guru/images/patterns/diagrams/decorator/solution2.png?id=3af1a4b6994c29000217)

Sendo assim, temos nosso `ConcreteComponent` sendo a classe `Notifier.`

```ruby
class Notifier
  def initialize(sender)
    @sender = sender
  end

  def send(message)
    puts message
    puts "From: #{@sender}"
    puts "\n"
  end
end
```

 A classe `Decorator` que definirá a interface para os demais `Decorators`, como os `SmsDecorator` e `SlackDecorator`. 

```ruby
class Decorator 
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    @notifier.send(message)
  end  
end

class SmsDecorator < Decorator
  def initialize(notifier)
    super(notifier)
  end

  def send(message)
    @notifier.send("New SMS \n\t#{message}")
  end
end

class SlackDecorator < Decorator
  def initialize(notifier)
    super(notifier)
  end

  def send(message)
    @notifier.send("New Slack Message \n\t#{message}")
  end
end
```

Para exemplificar o uso de `Decorators` aninhados foi criada a classe `TimeStampDecorator`.

```ruby
class TimeStampDecorator < Decorator
  def send(message)
    @notifier.send("#{message} \nTime: #{Time.new.strftime("%k:%M")}")
  end
end
```

Com tal modelagem é possível adicionar novas responsabilidades a objetos de forma dinâmica, além de permitir a união de ilimitados  `Decorators` quando eles compartilham a mesma interface.

### Consequências

- Maior flexibilidade do que a herança estática;
- Evita classes-mãe sobrecarregadas;
- Um decorator e o seu componente não são idênticos;
- Grande quantidade de objetos pequenos, dificultando a compreensão e depuração.