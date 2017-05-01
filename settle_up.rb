require 'pry'
require 'yaml'
require './payment'
require './person'
require './people_builder'

class SettleUp

  private
  attr_accessor :people
  attr_accessor :payments
  attr_accessor :current_group
  public

  def initialize(people)
    @yaml = YAML.load_file('paid.yml')
    setup_options
    @people = people
    @current_group = people.dup
    @payments = []
  end

  def call
    while current_group.count > 1
      order_current_group
      pair_payment
    end
  end

  def validate_payments
    print "\n\nValidating Payments"

    @people.each do |person|
      value = person.paid
      @payments.each do |payment|
        if payment.to == person.name
          value -= payment.amount
        elsif payment.from == person.name
          value += payment.amount
        end
      end
      printf "\n%-#{name_size}s paid $%-5d" % [person.name, value]
    end
  end

  def print_payments
    size = name_size
    puts "\n\nfrom #{' '*(size-5)} --> to#{' '*(size-2)} : amount"
    print "------------------------"
    payments.each do |p|
      printf "\n%-#{size}s --> %-#{size}s : $%-5d" % [p.from, p.to, p.amount]
    end
  end

  private

  def setup_options
    yaml = YAML.load_file('paid.yml')
    @options = yaml['options'] || {}
  end

  def name_size
    people.map(&:name).sort_by{|n| n.size}.pop.size
  end

  def order_current_group
    current_group.sort_by!{|p| p.balance }
  end

  def pair_payment
    smallest = current_group.first
    largest = current_group.last
    payments << Payment.new(from: smallest, to: largest, options: @options)
    if smallest.balance > -1 && smallest.balance < 1
      current_group.shift
    end
    if largest.balance > -1 && largest.balance < 1
      current_group.pop
    end
  end

end

people = PeopleBuilder.new.call
settler = SettleUp.new(people)
settler.call
settler.print_payments
settler.validate_payments

