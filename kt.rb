class Knight
  BOARD = Array.new(8) { Array.new(8) }

  def initialize()
    BOARD.each_index do |i|
      row = BOARD[i]
      row.each_index do |j|
        BOARD[i][j] = BoardCell.new(i,j)
      end
    end
  end

  def knights_moves(start_pos, finish_pos)
    starting_cell = BOARD[start_pos[0]][start_pos[1]]
    finish_cell = BOARD[finish_pos[0]][finish_pos[1]]

    same_gen_nodes = [starting_cell]
    path = find_path(same_gen_nodes, finish_cell)
    print path
    print "Your Knight can reach from cell #{start_pos} to cell #{finish_pos} in #{path.length} moves."
  end

  private

  # DFS style. Need to make it BFS to work
  def find_path(same_gen_nodes, finish)
    temp = []
    same_gen_nodes.each do |node|
      temp.push(next_move(node))
      return build_path(finish) if temp.include?(finish)
    end

    find_path(temp, finish)
  end

  def build_path(finish)
    root_found = false
    path = []
    node = finish
    until root_found do
      path.unshift(node.parent)
      node = node.parent
    end
  end

  def next_move(root)
    cells_shift = [-2,-1,1,2]
    result = []

    cells_shift.each do |shift_x|
      cells_shift.each do |shift_y|
        x = root.x + shift_x
        y = root.y + shift_y

        if x.between?(0, 7) && y.between?(0, 7)
          result.push(BOARD[x][y])
          BOARD[x][y].parent = root
        end
      end
    end

    return result
  end
end

class BoardCell
  attr_accessor :parent
  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x, y
    @parent = Nil
  end
end
