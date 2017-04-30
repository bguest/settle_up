class Person
  attr_accessor :name, :paid, :balance

  def initialize(name:, paid:)
    @name = name
    @paid = Array(paid).inject(:+)
  end

  def owe=(value)
    self.balance = paid - value
  end

end
