class Matrix
    def initialize(inp)
        @rows = inp.split("\n").map { |row|
            row.split(' ').map { |elem| elem.to_i }
        }
    end

    def row(row_num)
        @rows[row_num-1]
    end

    def column(col_num)
        @rows.map { |row| row[col_num-1] }
    end
end