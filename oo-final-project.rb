class Tool
    attr_accessor :tool_health
    attr_reader :tool_name
    def initialize(tool_name, time_used)
        @tool_name = tool_name
        @time = time_used
        @tool_health = 100
        @current_time = 0
    end
    
    def damage(item_damaged)
        until @current_time == @time || item_damaged.item_health == 0 || @tool_health == 0
            item_damaged.item_health -= 5
            @tool_health -= 10
            @current_time += 1
        end
    end
end

class Item
    attr_accessor :item_health
    def initialize(item_name, item_health)
        @item_name = item_name
        @item_health = item_health
    end
    
    def broken(tool_condition)
        if @item_health == 0 && tool_condition.tool_health == 0
            puts "Both #{@item_name} and #{tool_condition.tool_name} break at the same time!"
        elsif @item_health <= 0
            puts "The #{@item_name} breaks first!"
        elsif tool_condition.tool_health <= 0
            puts "Your #{tool_condition.tool_name} breaks first!"
        else
            puts "Nothing breaks. \nYour #{tool_condition.tool_name}'s health is now #{tool_condition.tool_health}. \nThe #{@item_name}'s health is now #{@item_health}."
        end
    end
end

def start
    puts "This is a game where you create a tool and an item you want to destroy. You will choose how many times you want to hit the item to see which one breaks first, none of them breaks, or both breaks at the same time. Your tool will have 100 health and you get to choose the heath of the item."
    puts "What tool will you use?"
    name_of_tool = gets.chomp
    puts "What is the item you'll hit?"
    name_of_item = gets.chomp
    puts "What is the health of the #{name_of_item}? (Enter a number greater than 0)"
    health_of_item = gets.chomp
    until health_of_item =~ /^-?[0-9]+$/ && health_of_item.to_i > 0
      puts "Reenter health"
      health_of_item = gets.chomp
    end
    puts "How many times will you hit? (Enter a number no less than 0)"
    number_of_hit = gets.chomp
    until number_of_hit =~ /^-?[0-9]+$/ && number_of_hit.to_i >= 0
      puts "Reenter the number of hits"
      number_of_hit = gets.chomp
    end
    tool = Tool.new(name_of_tool, number_of_hit.to_i)
    item = Item.new(name_of_item, health_of_item.to_i)
    tool.damage(item)
    item.broken(tool)
end

start
loop do
	puts "Do you want to keep playing?"
	answer = gets.chomp.downcase
	if answer == "yes"
		start
	elsif answer == "no"
		break
	else
		redo
	end
end