class Weapon < Item

  attr_reader :damage

  def initialize(name, weight, damage)
    super(name, weight)
    @damage = damage
    @weapon = []
  end

  def hit(unit)
    unit.wound(damage)
  end



end
