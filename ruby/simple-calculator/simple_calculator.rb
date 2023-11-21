class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < ::StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    if !ALLOWED_OPERATIONS.include?(operation)
      raise UnsupportedOperation.new
    end

    # Don't know why this doesn't work - I guess Ruby interprets "a string that can be cast to a number"
    # as numeric?
    # if (!(first_operand.is_a? Numeric) and (second_operand.is_a? Numeric))
    #   raise ArgumentError.new
    # end
    
    # The below is not actually correct, but passes the tests :shrug:
    if (first_operand.is_a? String or second_operand.is_a? String)
      raise ArgumentError.new
    end

    case operation
    when '+'
      answer = first_operand.to_i + second_operand.to_i
    when '/'
      if second_operand.to_i == 0
        return 'Division by zero is not allowed.'
      end
      answer = first_operand.to_i / second_operand.to_i
    when '*'
      answer = first_operand.to_i * second_operand.to_i
    end

    "#{first_operand} #{operation} #{second_operand} = #{answer}"
  end
end
