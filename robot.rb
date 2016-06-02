# require 'rspec'
require_relative 'item'
require_relative 'weapon'
require_relative 'plasma_cannon'
require_relative 'laser'
require_relative 'box_of_bolts'
require_relative 'grenade'

class Robot

  attr_accessor :equipped_weapon

  attr_reader :position, :items, :items_weight, :weight, :health

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    weight = []
    if (items_weight + item.weight) <= 250
      @items << item
      @items_weight += item.weight
      # @items.each{|row| weight << row.weight}
      # @items_weight = weight.inject(0){|sum,x| sum + x }
      p @equipped_weapon = item if item.is_a?Weapon
      if health <= 80
        item.feed(self) if item.is_a?BoxOfBolts
      end
      true
    end
  end

  def wound(damage)
    @health -= damage
    @health = 0 if health < 0
  end

  def heal(add_health)
    @health += add_health
    @health = 100 if health > 100
  end

  def attack(enemy)
    if (position[0]-enemy.position[0]).abs == 1 || (position[1]-enemy.position[1]).abs == 1
      if equipped_weapon == nil
        enemy.wound(5)
      else
        equipped_weapon.hit(enemy)
      end
    elsif (position[0]-enemy.position[0]).abs == 2 || (position[1]-enemy.position[1]).abs == 2 
        equipped_weapon.hit(enemy) if equipped_weapon.is_a?Grenade
    end
    if equipped_weapon.is_a?Grenade
      @equipped_weapon =nil
    end
  end

  def heal!(add_health)
    # begin
    #   raise DeadRobotError,'Robot is already Dead!' if health==0
    #   rescue DeadRobotError
    #     puts "Rescued!"
    # end
    heal(add_health) 
  end

  # class DeadRobotError < RuntimeError
  # end

end

# @robot = Robot.new
# @robot2 = Robot.new
#         @robot2.move_up

#          @robot.attack(@robot2)

# robot =Robot.new
# p robot.heal!(5)
# weapon = Grenade.new
# p robot.equipped_weapon

# item1=Item.new("sam", 20)
# item2=Item.new("sm", 10)
#  p robot.pick_up(weapon)
#  robot2=Robot.new
# p robot.attack(robot2)
# p robot.pick_up(item2)