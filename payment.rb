class Payment
  attr_reader :amount, :from, :to

  def initialize(from:, to:, options:)
    @owed_make_payments = options.fetch('allow_owed_to_make_payment'){ true }
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
    if @owed_make_payments
      @amount = -@from_person.balance
    else
      @amount = [-@from_person.balance, @to_person.balance].min
    end
    @to_person.balance -= amount
    @from_person.balance += amount
  end

end
