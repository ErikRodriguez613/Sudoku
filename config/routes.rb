Rails.application.routes.draw do
  post 'sudoku/setup'
  post 'sudoku/check'
  post 'sudoku/submit'
  post 'sudoku/solve'
  root 'sudoku#setup'
end
