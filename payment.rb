class Payment
  attr_reader :amount, :from, :to

  def initialize(from:, to:)
    @from_person = from
    @to_person = to
    adjust_balances
  end

  def from
    @from_person.name
  end

  def to
    @to_person.name
  end

  private

  def adjust_balances
    @amount = -@from_person.balance
    @to_person.balance -= amount
    @from_person.balance = 0
  end

end
