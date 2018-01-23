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
      next if index == 6 || index == 13
        arry << :stone << :stone << :stone << :stone 
      end 
   
  end
  

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    unless start_pos.between?(1, 13)
      raise "Invalid starting cup"
    end
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos = 1, current_player_name = @name1)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    
      pos = start_pos + 1
      until stones.empty? 
        if  current_player_name == @name1 
          pos = 0 if pos == 13
          break if stones.empty?
          @cups[pos] << stones.shift 
        else
          pos = 0 if pos == 14
          pos = 7 if pos == 6
          break if stones.empty?
          @cups[pos] << stones.shift 
        end
        pos += 1 
      end 
      self.render
      if @cups[pos].length == 1 
         return :switch 
      end
        self.next_turn(pos)
       
  end
  
  def switch
    if @current_player == @name1 
       @current_player = @name2
    else 
      @current_player = @name1 
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
