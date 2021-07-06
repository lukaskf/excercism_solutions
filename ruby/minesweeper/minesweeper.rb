=begin
Write your code for the 'Minesweeper' exercise in this file. Make the tests in
`minesweeper_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/minesweeper` directory.
=end

class Board

  def self.edge_check!(row)
    raise ArgumentError unless row[0] == '+' && row[-1] == '+' #check ends
    msg = "first and last row must be of the form '+---+'"
    row[1..-2].each{ |char| raise(ArgumentError.new msg) if char != '-'}
    row.join('')
  end

  # Indexes
  # (-1, -1), (-1,  0), (-1,  1)
  # ( 0, -1), ( 0,  0), ( 0,  1)
  # ( 1, -1), ( 1,  0), ( 1,  1)
  def self.find_mines(row_index, char_index, board)
    mines = 0
    (row_index-1..row_index+1).each do |r|
      (char_index-1..char_index+1).each do |c|
        if r!=0 && r!=board.length && c!=0 && c!=board[r].length
          mines += 1 if board[r][c] == '*'
        end
      end
    end
    return ' ' if mines == 0
    mines
  end

  def self.row_check!(row_index, row, board)
    msg = "rows must be of same length as the first"
    raise(ArgumentError.new msg) if row.length != board.first.length

    transformed = ""
    row.each_with_index do |char, char_index|
      # check edge
      if char_index == 0 || char_index == row.length-1
        char == '|' ? transformed += char : raise(ArgumentError.new "rows must end with |")
      # check row
      else
        case char
        when '*'
          transformed += char
        when ' '
          transformed += find_mines(row_index, char_index, board).to_s
        else
          raise ArgumentError.new "row characters must be one of |, *, ' '"
        end
      end
    end
    transformed
  end

  def self.transform(board)
    result = []
    board = board.map{ |row| row.split('')}
    board.each_with_index do |row, index|
      if index == 0 || index == board.length-1
        result.append edge_check!(row)
      else
        result.append row_check!(index, row, board)
      end
    end
    result
  end
end

