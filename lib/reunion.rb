class Reunion
  attr_reader :name,
              :activities

  def initialize(name)
    @name       = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum do |activity|
      activity.total_cost
    end
  end

  def breakout
    breakout = Hash.new(0)
    @activities.each do |activity|
      activity.participants.each do |participant, amount_paid|
        breakout[participant] += activity.owed[participant]
      end
    end
    breakout
  end

  def summary
    summary = ""
    breakout.each do |participant, owed|
      summary += "#{participant}: #{owed.to_s}\n"
    end
    summary.chomp
  end

  def detailed_breakout
    detailed_breakout = Hash.new { |hash, key| hash[key] = [] }
    @activities.each do |activity|
      activity.participants.each do |participant, owed|
        detailed_breakout[participant] << {
            activity: activity.name,
            payees:   activity.payees(participant),
            amount:   activity.owed_per_payee(participant)
          }
          # require "pry"; binding.pry
      end
    end
    detailed_breakout
  end
end
