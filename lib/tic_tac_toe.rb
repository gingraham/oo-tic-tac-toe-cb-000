class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row

    [0,3,6], # Left col
    [1,4,7], # Middle col
    [2,5,8], # Right col

    [0,4,8], # Left top corner row
    [2,4,6], # Right top corner row
  ]


  def input_to_index(user_input)
    user_input.to_i - 1
  end

  # Move Method
  def move(index, current_player)
    @board[index] = current_player
  end

  # Checks if the position is available
  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  # Checks user input validity
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  # Initializes the player turn
  def turn
    puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    if !valid_move?(index)
        turn
    else
        move(index,current_player)
        display_board
    end
  end

  # Returns the wining combination
  def won?
   WIN_COMBINATIONS.each do |combo|
     if position_taken?(combo[0]) && position_taken?(combo[1]) && position_taken?(combo[2])
       if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
         return combo
       end
     end
   end
   return false
  end

  # Checks for a draw game
  def draw?
   if won?
     return false
   elsif full?
     return true
   end
  end

  # Checks for a full board
  def full?
      @board.each do|i| if (i == nil || " " == i)
         return false
          end
      end
  end

  # Checks if the game is over
  def over?
    draw?|| won?|| full?
  end

  # Determines the winner
  def winner
    win = won?
    if win
      return @board[win[0]]
    end
  end

  #Initializes the game
  def play
   until over?
     turn
   end
   if won?
     puts "Congratulations #{winner}!"
   elsif draw?
     puts "Cat's Game!"
   end
  end

end
