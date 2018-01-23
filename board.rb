class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1 
    @name2 = name2
    @cups = Array.new(14){Array.new(0)}
    self.fill_cups
  end
  
  def fill_cups 
    @cups.each.with_index do |arry, index| 
      next if index == 0 || index == 13
        arry << :stone << :stone << :stone << :stone 
      end 
   
  end
  

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    unless start_pos.between?(1, 6) || start_pos.between?(8, 13)
      raise "Invalid starting cup"
    end
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    @cups[start_pos] = []
    
      stones = @cups[start_pos]
      pos = start_pos + 1
      until stones.empty? 
        if current_player_name == @name1 
          pos = 0 if pos == 0
          @cups[pos] << stone.shift 
        else
          pos = 8 if pos == 13
          @cups[pos] << stone.shift 
        end
        pos += 1 
      end 
       
  end
  

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
