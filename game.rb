class Player
  attr_reader :sigil, :name
  def initialize(name, sigil)
    @name = name
    @sigil = sigil
  end  

  def play_turn
    print "\n#{@name} - Enter a position for next move: "
    inp = gets.chomp.to_i
    return inp
  end  
end  

class Game
  

  def initialize
    @grid_help = [
      [7,8,9],
      [4,5,6],
      [1,2,3]
    ]

    @grid = [
      [' ',' ',' '],
      [' ',' ',' '],
      [' ',' ',' ']
    ]

    @players = [Player.new("Player_X", 'X'),Player.new("Player_O", 'O')]

    @turn = 0
  end 
  
  def get_ij(n)
    if n == 10
      print_grid_help
      puts "Now choose a place..."
      return -1,-1
    end  
    i = -1
    for ii in (0..2)
      i = ii if @grid_help[ii].include?(n)
    end
    
    if i == -1
      puts "choose a valid place , Enter 10 for help.."
      return -1,-1
    end  

    j = -1
    for ii in (0..2)
      j = ii if @grid_help[i][ii] == n
    end
    
    if j == -1
      puts "choose a valid place , Enter 10 for help.."
      return -1,-1
    elsif @grid[i][j] != ' '
      puts "that place is not empty.."
      return -1,-1
    else 
      return i,j
    end      

    return i,j

  end  

  def print_grid
    disp = @grid.map {|e| e.join(" | ")}.join("\n-----------\n ")
    disp = "\n " + disp
    puts disp
  end 
  
  def print_grid_help
    disp = @grid_help.map {|e| e.join(" | ")}.join("\n-----------\n ")
    disp = " " + disp
    puts disp
  end   

  def next_turn
    @turn = 1 - @turn

    print_grid

    i = -1
    j = -1
    while i == -1 || j == -1 
      n = @players[@turn].play_turn
      i,j = self.get_ij(n)
    end  

    @grid[i][j] = @players[@turn].sigil

    if check_win(i, j, @players[@turn].sigil)
      print_grid
      puts "#{@players[@turn].name} has won!!"
      return false
    else 
      return true
    end
    
    p "HMM"
    return false
  end  

    
  def check_win(i, j, c)
    win = @grid[i].all? {|e| e == c}
    return true if win

    win =true
    for ii in (0..2) 
      win = false if @grid[ii][j] != c
    end  
    return true if win
    
    win = true
    if (i+j).even?
      for ii in (0..2)
        win = false if @grid[ii][ii] != c
      end
      return true if win
      
      win = true
      for ii in (0..2)
        win = false if @grid[ii][2-ii] != c
      end
      return true if win
    end    
    return false
  end  

  def play
    in_progress = true
    turns = 0
    while in_progress && turns < 9
      in_progress = self.next_turn
      turns += 1
    end  

    if in_progress && turns >= 9
      print_grid
      puts "Thats a tie.."
    end  
  end  


end

game = Game.new

puts "Enter places according to the grid:"
game.print_grid_help
puts " "
game.play
