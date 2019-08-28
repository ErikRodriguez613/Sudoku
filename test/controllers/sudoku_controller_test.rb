require 'test_helper'

class SudokuControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get sudoku_setup_url
    assert_response :success
  end

  test "should get check" do
    get sudoku_check_url
    assert_response :success
  end

  test "should get submit" do
    get sudoku_submit_url
    assert_response :success
  end

  test "should get solve" do
    get sudoku_solve_url
    assert_response :success
  end

  test "should get restart" do
    get sudoku_restart_url
    assert_response :success
  end

end
