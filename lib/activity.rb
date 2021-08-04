class Activity
  attr_reader :name,
              :participants

  def initialize(name)
    @name         = name
    @participants = {}
  end

  def add_participant(name, amount_paid)
    @participants[name] = amount_paid
  end

  def total_cost
    @participants.sum do |name, amount_paid|
      amount_paid
    end
  end
end
