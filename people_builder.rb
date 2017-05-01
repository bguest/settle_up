
class PeopleBuilder

  private
  attr_accessor :people
  public

  def initialize()
    @yaml = YAML.load_file('paid.yml')
  end

  def call
    self.people = @yaml['people'].map do |k,v|
      Person.new(name: k, paid: v)
    end
    set_inital_balance
    print_balances
    people
  end

  def print_balances
    puts "Name  Paid  Balance"
    print "-------------------"
    size = people.map(&:name).sort_by{|n| n.size}.pop.size
    people.each do |p|
      printf "\n%-#{size}s : $%-5d: $%-5d" % [p.name, p.paid, p.balance]
    end
  end

  private

  def set_inital_balance
    total = people.map(&:paid).inject(:+)
    owed = total.to_f/people.count
    people.each{ |p| p.owe = owed}
  end
end
