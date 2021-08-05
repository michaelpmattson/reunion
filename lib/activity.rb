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

  def split
    total_cost / @participants.count
  end

  def owed
    owed = {}
    @participants.each do |name, amount_paid|
      owed[name] = split - amount_paid
    end
    owed
  end

  def owed_per_payee(name)
    owed[name] / payees(name).count
  end

  def payees(name)
    payees = []
      @participants.each do |participant, amount_paid|
        if participant != name && owed[participant] != owed[name]
          payees << participant
        end
      end
    payees
  end
end
