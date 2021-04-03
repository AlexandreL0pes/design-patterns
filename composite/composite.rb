
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


class Processor < Equipment
  def initialize
    super('AMD Ryzen 7', 2200.00)
  end  
end

class GraphicCard < Equipment
    def initialize 
        super('Nvidia Graphic Card 4gb', 1500.00)
    end     
end

class RamMemory < Equipment
  def initialize
      super('Hyper X RAM Memory 16gb', 500.0)
  end 
end

class Mouse < Equipment
  def initialize
    super('Logitech Anywhere 2s', 300.00)
  end
end

class Keyboard < Equipment
  def initialize
    super('Redragon Kumara', 350.00)
  end

  def use 
    p "tec tec tec"
  end
end

class MotherBoard < CompositeEquipment
  def initialize
    super('Asus MotherBoard X570-Plus', 1500.00)
  end
end

class UsbHub < CompositeEquipment
  def initialize
    super('USB Hub', 100.00)
  end

end


mother_board = MotherBoard.new

processor = Processor.new
graphic_card = GraphicCard.new
ram_memory = RamMemory.new

mother_board.add_equipment(processor)
mother_board.add_equipment(graphic_card)
mother_board.add_equipment(ram_memory)

usb_hub = UsbHub.new

mouse = Mouse.new 
keyboard = Keyboard.new

usb_hub.add_equipment(mouse)
usb_hub.add_equipment(keyboard)

mother_board.add_equipment(usb_hub)

p "Total Price - MotherBoard: #{mother_board.get_price}"
p "Total Price - USB Hub: #{usb_hub.get_price}"

mother_board.remove_equipment(graphic_card)
p "Total Price - MotherBoard -> Without GraphicCard: #{mother_board.get_price}"

keyboard.use