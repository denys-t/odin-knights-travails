class Knight
  BOARD = Array.new(8) { Array.new(8) }

  def initialize()
    BOARD.each_index do |i|
      row = BOARD[i]
      row.each_index do |j|
        BOARD[i][j] = BoardCell.new(i, j)
      end
    end
  end

  def knight_moves(start_pos, finish_pos)
    start_cell = BOARD[start_pos[0]][start_pos[1]]
    finish_cell = BOARD[finish_pos[0]][finish_pos[1]]

    same_gen_nodes = [start_cell]
    path = find_path(same_gen_nodes, start_cell, finish_cell)
    pretty_print(path)
    puts "Your Knight can reach from cell #{start_pos} to cell #{finish_pos} in #{path.length - 1} moves."

    initialize_board
  end

  private

  def find_path(same_gen_nodes, start, finish)
    temp = []
    same_gen_nodes.each do |node|
      temp.push(next_move(node, start))
      return build_path(finish) if temp.flatten.include?(finish)
    end

    find_path(temp.flatten, start, finish)
  end

  def build_path(finish)
    path = [[finish.x, finish.y]]
    node = finish
    until node.parent.nil?
      path.unshift([node.parent.x,node.parent.y])
      node = node.parent
    end

    return path
  end

  def next_move(cell, start)
    cells_shift = [-2, -1, 1, 2]
    result = []

    cells_shift.each do |shift_x|
      cells_shift.each do |shift_y|
        next if (shift_x * shift_y).abs == 1

        x = cell.x + shift_x
        y = cell.y + shift_y

        if x.between?(0, 7) && y.between?(0, 7) && BOARD[x][y].parent.nil? && BOARD[x][y] != start
          result.push(BOARD[x][y])
          BOARD[x][y].parent = cell
        end
      end
    end

    return result
  end

  def initialize_board
    BOARD.each_index do |i|
      row = BOARD[i]
      row.each_index do |j|
        BOARD[i][j].parent = nil
      end
    end
  end

  def pretty_print(path)
    result = "Knight's path: "
    path.each_with_index do |cell, i|
      result += "(#{cell.join(', ')})"
      result += ' >> ' if i != path.length - 1
    end

    puts result
  end
end

class BoardCell
  attr_accessor :parent
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @parent = nil
  end
end

kkk = Knight.new

start = [4,6]
finish = [5,6]
kkk.knight_moves(start, finish)
