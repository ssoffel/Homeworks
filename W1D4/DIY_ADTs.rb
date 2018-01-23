class Stack
  attr_accessor :line
    def initialize
      @line = Array.new
    end

    def add(el)
       @line.push(el)
    end

    def remove
       @line.pop
    end

    def show
       puts @line
    end
  end
  
  class Queue 
    
    def initialize
      @line = Array.new
    end

    def enqueue(el)
       @line.push(el)
    end

    def deque
       @line.pop
    end

    def show
       puts @line
    end
  end
  
  class Map 
    
    def initialize
      @my_map = Array.new
    end 
    
    def assign(key, value) 
      @my_map.each do |arry| 
        if key == arry[0]
          return nil 
        end 
      end 
      @my_map << [key, value]
    end
    
    def lookup(key)
      @my_map.each do |arry| 
        if key == arry[0]
          return arry
        end 
      end
    end
    
    def remove(key) 
      @my_map.each do |arry| 
        if key == arry[0]
           @my_map.delete(arry)
        end 
      end
    end
    
    def show 
      p @my_map
    end
    
  end
  
  m = Map.new 
  m.assign("H", 5)
  m.assign("K", 9)
  m.remove("K")
  p m.lookup("H")
  m.show
  
   