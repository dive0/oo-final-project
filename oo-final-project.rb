class Tool
    attr_accessor :tool_health
    attr_reader :tool_name
    def initialize(tool_name, time_used)
        @tool_name = tool_name
        @time = time_used
        @tool_health = 100
        @current_time = 0
    end
    
    def damage(material_damaged)
        until @current_time == @time || material_damaged.material_health == 0 || @tool_health == 0
            material_damaged.material_health -= 5
            @tool_health -= 10
            @current_time += 1
        end
    end
end

class Material
    attr_accessor :material_health
    def initialize(material_name, material_health)
        @material_name = material_name
        @material_health = material_health
    end
    
    def broken(tool_condition)
        if @material_health == 0 && tool_condition.tool_health == 0
            puts "Both #{@material_name} and #{tool_condition.tool_name} break at the same time!"
        elsif @material_health == 0
            puts "The #{@material_name} breaks first!"
        elsif tool_condition.tool_health == 0
            puts "Your #{tool_condition.tool_name} breaks first!"
        else
            puts "Nothing breaks. Your #{tool_condition.tool_name}'s health is now #{tool_condition.tool_health}. The #{@material_name}'s health is now #{@material_health}"
        end
    end
end

def start
    puts "This is a game where you create a tool and an object you want to destroy. You will choose how many times you want to hit the object to see which one breaks first, none of them breaks, or both breaks at the same time. Your tool will have 100 health and you get to choose the heath of the object."
    puts "What tool will you use?"
    name_of_tool = gets.chomp
    puts "What object will you hit?"
    name_of_object = gets.chomp
    puts "What is the health of the #{name_of_object}?"
    health_of_object = gets.chomp.to_i
    puts "How many times will you like to hit?"
    number_of_hit = gets.chomp.to_i
    tools = Tool.new(name_of_tool, number_of_hit)
    materials = Material.new(name_of_object, health_of_object)
    tools.damage(materials)
    materials.broken(tools)
end

start