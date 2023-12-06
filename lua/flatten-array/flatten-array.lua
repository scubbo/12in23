local function flatten(input)
    local out = {}
    for i=1, #input do
        local elem = input[i];
        -- io.stdout:write("DEBUG - handling element number ")
        -- io.stdout:write(i)
        -- io.stdout:write("\n")

        if elem == nil then
            -- io.stdout:write("It is nil - skipping\n")
            -- https://stackoverflow.com/a/12929685/1040915
            goto continue
        end

        if type(elem) == "table" then
            -- io.stdout:write("It is a table - recursing\n")
            local flattened = flatten(elem)
            for j=1, #flattened do
                table.insert(out, flattened[j])
            end
            goto continue
        end

        -- Else - item is a non-nil primitive
        -- io.stdout:write("It is a non-nil primitive (")
        -- io.stdout:write(elem)
        -- io.stdout:write(") - appending\n")
        table.insert(out, elem)

        ::continue::
    end

    return out

end

return flatten
