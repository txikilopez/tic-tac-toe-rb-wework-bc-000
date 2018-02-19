# Helper Method

#Position Taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# WIN_COMBINATIONS
WIN_COMBINATIONS =  [
  [0,1,2], #row 1
  [3,4,5], #row 2
  [6,7,8], #row 3
  [2,4,6], #diagonal 2
  [0,4,8], #diagonal 1
  [0,3,6], #column 1
  [1,4,7], #column 2
  [2,5,8], #column 3
]

  #Play
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts("Congratulations " + winner(board) + "!")
  else
    puts("Cat's Game!")
  end
end

  
#FULL BOARD CODE
def full?(board)
  !(board.any? {|slot| slot == " " || slot == ""})
end


#WON CODE
def won?(board)
  
  winning_move = nil
  
  WIN_COMBINATIONS.each do |move_win|
    position_1 = move_win[0]
    position_2 = move_win[1]
    position_3 = move_win[2]
    
    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      winning_move = move_win
    elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      winning_move = move_win
    end
  end
  winning_move
end


#DRAW CODE
def draw?(board)
  full?(board) && !won?(board)
end

#OVER CODE
def over?(board)
  won?(board) || draw?(board) || full?(board)  || turn_count(board) == 9
end


#WINNER CODE
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


#turn count
def turn_count(board)
  board.count{|x| x !=" "}
end


# Turn
def turn(board)
  puts("Please enter 1-9:")
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


#Move
def move(board, index, character)
  board[index] = character
end

#input to index
def input_to_index(input)
  index = input.to_i - 1
end


#Valid Move?
def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
      true
  else
    false
  end
end


#Display Board
def display_board(board)
  puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("-----------")
  puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("-----------")
  puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end


#Player X or O
def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end