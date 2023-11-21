module SavingsAccount
  def self.interest_rate(balance)
    # Cannot, AFAIK, use `case`, because that can only do literal matches, not pattern/if-clause matching
    if 0<= balance and balance < 1000
      return 0.5
    elsif 1000 <= balance and balance < 5000
      return 1.621
    elsif 5000 <= balance
      return 2.475
    else # Negative balance
      return 3.213
    end
  end

  def self.annual_balance_update(balance)
    balance + (balance * self.interest_rate(balance) * 0.01)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0
    until current_balance >= desired_balance
      years += 1
      current_balance = self.annual_balance_update(current_balance)
    end
    return years
  end
end
