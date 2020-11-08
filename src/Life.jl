module Life
  export repeater, stable, next_board

  repeater() = [
                   false false false; 
                   true  true  true; 
                   false false false
               ]
               
  stable() = [
               false true  true  false; 
               true  false false true ; 
               true  false false true ; 
               false true  true  false
             ]

  function get_at(board, row, col)
    (h, w) = size(board)
    
    if (row in 1:h) && (col in 1:w) 
      board[row, col]
    else
      false
    end
  end

  function neighbors(grid, r, c)
    [
      get_at(grid, row, col) ? 1 : 0 
      for row in (r-1:r+1), col in (c-1:c+1) 
        if (r, c) != (row, col)
    ] |> 
    sum
  end
  

  function cell(count, value)
    if count < 2
      false
    elseif count > 3
      false
    elseif count == 3
      true
    else
      value
    end
  end

  function next_board(life)
    (rows, cols) = size(life)
    [
      cell(neighbors(life, row, col), get_at(life, row, col)) 
      for row in 1:rows, col in 1:cols
    ]
  end
end # module
