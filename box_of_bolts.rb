class BoxOfBolts < Item

  attr_reader :name, :weight

  def initialize
    @name = "Box of bolts"
    @weight = 25
  end

  def feed(unit)
    unit.heal(20)
  end

end
