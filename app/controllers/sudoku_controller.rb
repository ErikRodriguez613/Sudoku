require_relative "../services/sudoku_service"

class SudokuController < ApplicationController
  def setup
    sudoku = SudokuBoard.new(9, 25, logger)
    $board, $results = sudoku.generate_board
    logger.info ("Generated sudoku board")
  end

  def check
    logger.info("Checking board against cache")
    board = params[:sudoku]
    $errors = Hash.new
    for row in board
      index = row[0].split("")
      row_index = index[0]
      col_index = index[1]
      sub_value = row[1]
      res_value = $results[row_index.to_i][col_index.to_i]
      if (sub_value != res_value.to_s)
        $errors[row[0]] = row[0]
      end
      $board[row_index.to_i][col_index.to_i] = sub_value
    end
  end

  def solve
    $results
    logger.info("returning results")
  end
end
