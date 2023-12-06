local all_your_base = {}

all_your_base.convert = function(from_digits, from_base)
  local return_value = {}

  -- Edge case - empty input
  if #from_digits == 0 then
    return_value.to = function(to_base)
      return {0}
    end
    return return_value
  end

  -- Edge case - too-small base
  if from_base < 2 then
    error("invalid input base")
  end


  local actual_value = 0;
  for i=1, #from_digits do
    local digit = from_digits[i]
    if digit < 0 then
      error("negative digits are not allowed")
    end
    if digit >= from_base then
      error("digit out of range")
    end

    actual_value = actual_value + ( digit * (from_base ^ (#from_digits - i)))
  end
--   io.stdout:write("Actual value is")
--   io.stdout:write(actual_value)
  if actual_value == 0 then
    return_value.to = function(to_base)
      return {0}
    end
    return return_value
  end

  return_value.to = function(to_base)
    if to_base < 2 then
      error("invalid output base")
    end

    local total_value = actual_value
    local digits = {}
    -- Could probably figure out the "length" of the return by doing logarithms, but that feels contrary to the spirit
    -- of learning programming (rather than mathematics). Instead - repeatedly do division/modulus (building up a table
    -- of values), then reverse the table.
    local index = 1


    while (total_value > 0) do
        local current_power_of_base = to_base ^ (index - 1)
        local next_power_of_base = to_base ^ index
        local remainder = math.fmod(total_value, next_power_of_base)
        local digit = remainder / current_power_of_base -- Always perfectly divisible, by induction
        digits[index] = digit
        total_value = total_value - remainder

        index = index + 1
    end
    
    -- Reverse the digits
    local output = {}
    -- io.stdout:write("DEBUG output:")
    for i=1, #digits do
       output[#digits - i + 1] = digits[i] 
       -- DEBUG output
    --    io.stdout:write(digits[i])
    end

    return output
  end

  return return_value
end

return all_your_base
