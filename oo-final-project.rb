#create the tool class and it's effects
class Tool
    attr_accessor :tool_health
    attr_reader :tool_name
    #the attricbutes of the tool when first creating it
    def initialize(tool_name, time_used)
        @tool_name = tool_name #make the given tool name into a instance variable to use in other area
        @time = time_used #make the given time used into a instance variable to use in other area
        @tool_health = 100
        @current_time = 0
    end
    
    #the damage done and what happen to the tool and item
    def damage(item_damaged) #allow the item class to be use through the parameter
        until @current_time == @time || item_damaged.item_health == 0 || @tool_health == 0
            item_damaged.item_health -= 5
            @tool_health -= 10
            @current_time += 1
        end
    end
end

class Item
    attr_accessor :item_health
    #when the item is first created, the inputs that the user put is save as instance variables
    def initialize(item_name, item_health)
        @item_name = item_name
        @item_health = item_health
    end
    
    #checks whether the tool breaks, the item breaks, both breaks, or nothing breaks
    def broken(tool_condition) #allow the tool class to be use through the parameter
        if @item_health == 0 && tool_condition.tool_health == 0 #when both health reach 0 at the same time
            puts "Both #{@item_name} and #{tool_condition.tool_name} break at the same time!"
        elsif @item_health <= 0 #when the item's health is 0 or below 0 before the tool's health
            puts "The #{@item_name} breaks first!"
        elsif tool_condition.tool_health <= 0 #when the tool's health reaches 0 or below 0 before the item's health
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
    #only allow the input of health to be a number and has to be greater than 0
    until health_of_item =~ /^-?[0-9]+$/ && health_of_item.to_i > 0 
        puts "Reenter health"
        health_of_item = gets.chomp
    end
    puts "How many times will you hit? (Enter a number no less than 0)"
    number_of_hit = gets.chomp
    #only allow the input of the times hit to be a number and has to be greater than or equal to 0
    until number_of_hit =~ /^-?[0-9]+$/ && number_of_hit.to_i >= 0
        puts "Reenter the number of hits"
        number_of_hit = gets.chomp
    end
    tool = Tool.new(name_of_tool, number_of_hit.to_i) #creating a new tool with the user's input
    item = Item.new(name_of_item, health_of_item.to_i) #creating a new item with the user's input
    tool.damage(item) #allow the values from the item class to be use in the damage method in tool class
    item.broken(tool) #allow the values from the tool class to be use in the broken method in item class
end

start
#ask if the user wants to play again
loop do
	puts "Do you want to play again?"
	answer = gets.chomp.downcase
	if answer == "yes"
		start
	elsif answer == "no"
		break
	else
		redo
	end
end