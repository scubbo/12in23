class CircularBuffer

    class BufferEmptyException < ::StandardError
    end

    class BufferFullException < ::StandardError
    end

    def initialize(size)
        @slots = Array.new(size)
        @old_index=0
        @next_index=0
    end

    def write(new_val)
       if @slots[@next_index] != nil
            raise BufferFullException
       end
       @slots[@next_index] = new_val
       @next_index = (@next_index + 1) % (@slots.size)
    end

    def write!(new_val)
        @slots[@next_index] = new_val
        if @next_index == @old_index
            @old_index = (@old_index + 1) % (@slots.size)
        end
        @next_index = (@next_index + 1) % (@slots.size)
    end

    def read
        return_val = @slots[@old_index]
        if return_val == nil
            raise BufferEmptyException
        end
        @slots[@old_index] = nil
        @old_index = (@old_index + 1) % (@slots.size)
        return_val
    end

    def clear
        @slots = Array.new(@slots.size)
    end
end
