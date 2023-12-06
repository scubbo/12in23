return {
  encode = function(s)
    local output = ""
    local cur_char = s:sub(1,1)
    local last_change = 1
    for i=2, #s do
      local latest_char = s:sub(i,i)
      if latest_char ~= cur_char then
        local run_length = i - last_change
        if run_length > 1 then
          output = output .. tostring(run_length)
        end
        output = output .. cur_char
        cur_char = latest_char
        last_change = i
      end
    end
    local run_length = #s - last_change + 1
    if run_length > 1 then
      output = output .. tostring(run_length)
    end
    output = output .. cur_char
    return output
  end,

  decode = function(s)
    local output = ""

    local last_change = 1
    local accumed_string = ""
    for i=1, #s do
      local char = s:sub(i,i)
      if not char:find("%D") then
        accumed_string = accumed_string .. char
      else
        local amount
        if accumed_string == "" then
          amount = 1
        else
          amount = tonumber(accumed_string)
        end
        for j=1, amount do
          output = output .. char
        end
        accumed_string = ""
      end
    end

    return output
  end
}
