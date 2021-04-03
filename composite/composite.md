# Composite

### Resumo
  Todas as classes implementam a mesma interface, permitindo a criação e manipulação de estruturas complexas de maneira simples.

### Objetivo
  Compor objetos em estruturas de árvore, permitindo que objetos individuais e composições sejam tratadas igualmente.

### Implementação
O padrão é implementado tem por base três classes: `Component`, `Leaf` e `Composite`. O `Component`, é a base para as demais classes, declarando assim uma interface comum para os objetos na composição. A classe `Leaf` representa os objetos-folha que estão na composição mas que não possuem filhos. Por fim, a classe `Composite` define o comportamento dos componentes que possuem filhos e implementa as operações onde os filhos estão presentes, com base na interface de `Component`.


### Exemplo

O código completo está no seguinte [arquivo](composite.rb).

Computadores são frequentemente organizados em hierarquias parte/todo. Por exemplo, um gabinete pode conter uma placa-mãe, que contém diversos barramentos, e estes podem compor diversos outros componentes. Tais estruturas podem ser modeladas naturalmente utilizando o padrão `Composite`.

No exemplo, a classe `Equipment` tem o papel de `Component`.

```ruby
class Equipment 
  attr_accessor :name, :price, :parent
  
  def initialize(name, price = 0.0)
      @name = name 
      @price = price
      @parent = nil
  end     
  
  def get_price
      self.price
  end 
end
```

A classe `CompositeEquipment` tem o papel de `Composite`.

```ruby
class CompositeEquipment < Equipment
  def initialize(name, price)
      super(name, price)
      @sub_equipments = [] 
  end 
  
  def add_equipment(equipment) 
      @sub_equipments << equipment
      equipment.parent = self
  end 
  
  def remove_equipment(equipment) 
      @sub_equipments.delete(equipment)
      equipment.parent = nil
  end
  
  def get_price 
      @sub_equipments.inject(self.price) { |price, equipment| price += equipment.get_price }
  end
end
```

E a classe `Processor` corresponde ao `Leaf`.

```ruby
class Processor < Equipment
  def initialize
    super('AMD Ryzen 7', 2200.00)
  end  
end
```

Com tal modelagem é possível adicionar e remover componentes facilmente, além de obter o preço total da máquina criada.

### Consequências
- Trata objetos e composições da mesma forma;
- Facilita a adição de novos componentes;
- Dificulta a restrição de componentes permitidos na composição;