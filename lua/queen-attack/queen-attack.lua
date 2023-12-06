return function(pos)
  local row = pos["row"]
  local column = pos["column"]
  
  if row == nil or column == nil or row < 0 or row > 7 or column < 0 or column > 7 then
    error("Illegal")
  end

  local output = {}
  output["row"] = row
  output["column"] = column
  output.can_attack = function(q2)
    if q2.row == row then
        return true
    end
    if q2.column == column then
        return true
    end
    if q2.row - row == q2.column - column then
        return true
    end
    if q2.row - row == column - q2.column then
        return true
    end
    return false
  end
  return output
end
