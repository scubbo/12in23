class Bst
    attr_reader :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

    def insert(new_val)
        # It would be cool to do this without duplicating the body of the if/else
        # clauses, but I don't see that that's possible since we will need to do assignment
        # _to_ the candidate-subtree, not just call methods on it.
        if new_val <= @data
            if @left == nil
                @left = Bst.new(new_val)
            else
                @left.insert(new_val)
            end
        else
            if @right == nil
                @right = Bst.new(new_val)
            else
                @right.insert(new_val)
            end
        end
    end

# Below is my original solution, which seems to _do_ the right thing, but
# doesn't return an Enumerator as desires by the last test
#     def each(&block)
#         if @left != nil
#             @left.each(&block)
#         end

#         # There must be a better way to directly invoke `&block` on a single value?
#         [@data].each(&block)

#         if @right != nil
#             @right.each(&block)
#         end
#     end

    def each(&block)
        return enum_for(:each) unless block_given?
        left.each(&block) if left
        yield(data)
        right.each(&block) if right
    end

end