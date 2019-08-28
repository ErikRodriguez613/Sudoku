class SudokuBoard
  def initialize(rows, missing_nums, logger)
    @rows = rows
    @missing_nums = missing_nums
    @sqrt = Math.sqrt(@rows).to_i
    @board = Array.new(@rows) { Array.new(@rows) }
    @logger = logger
  end

  def generate_board
    @logger.info "Filling diagonal"
    fill_diagonal
    @logger.info "Filling columns and rows"
    fill_rows_and_columns(0, @sqrt)
    @results = @board.map(&:clone)
    @logger.info "Removing cells"
    empty_cells
    return @board, @results
  end

  def empty_cells
    count = @missing_nums
    while count != 0
      cellId = random_num_gen(@rows * @rows)
      row = (cellId / @rows).to_i
      column = (cellId % @rows).to_i
      if (column != 0)
        column = column - 1
      end
      if (@board != nil && @board[row] != nil && @board[row][column] != nil)
        count = count - 1
        @board[row][column] = nil
      end
    end
  end

  def fill_diagonal
    i = 0
    while i < @rows
      @logger.info("Filling 3x3: " + i.to_s)
      fill_3x3(i, i)
      i = i + @sqrt
    end
  end

  def fill_rows_and_columns(row, column)
    if column >= @rows && row < (@rows - 1)
      row = row + 1
      column = 0
    end
    if row >= @rows && column >= @rows
      return true
    end
    if row < @sqrt
      if column < @sqrt
        column = @sqrt
      end
    elsif row < (@rows - @sqrt)
      columnVal = ((row / @sqrt) * @sqrt).to_i
      if column == columnVal
        column = column + @sqrt
      end
    else
      if column == (@rows - @sqrt)
        row = row + 1
        column = 0
        if row >= @rows
          return true
        end
      end
    end
    num = 1
    while num <= @rows
      if (!num_exists(row, column, num))
        @board[row][column] = num
        if (fill_rows_and_columns(row, column + 1))
          return true
        end
        @board[row][column] = nil
      end
      num = num + 1
    end
    return false
  end

  def fill_3x3(row, col)
    i = 0
    while i < @sqrt
      j = 0
      while j < @sqrt
        num = random_num_gen(@rows)
        until !exists_in_3x3(row, col, num)
          num = random_num_gen(@rows)
        end
        @board[row + i][col + j] = num
        j = j + 1
      end
      i = i + 1
    end
  end

  def exists_in_3x3(row, col, num)
    i = 0
    while i < @sqrt
      j = 0
      while j < @sqrt
        if @board[row + i][col + j] == num
          return true
        end
        j = j + 1
      end
      i = i + 1
    end
    return false
  end

  def exists_in_row(row, num)
    j = 0
    while j < @rows
      if @board[row][j] == num
        return true
      end
      j = j + 1
    end
    return false
  end

  def exists_in_column(column, num)
    i = 0
    while i < @rows
      if @board[i][column] == num
        return true
      end
      i = i + 1
    end
    return false
  end

  def num_exists(row, column, num)
    exists_in_3x3 = exists_in_3x3(row - (row % @sqrt), column - (column % @sqrt), num)
    exists_in_row = exists_in_row(row, num)
    exists_in_column = exists_in_column(column, num)
    num_exists = (exists_in_3x3) || (exists_in_row) || (exists_in_column)
    return num_exists
  end

  def random_num_gen(num)
    return 1 + rand(num)
  end
end
