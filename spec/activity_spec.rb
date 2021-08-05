require './lib/activity'

RSpec.describe Activity do
  describe '#initialize' do
    it 'exists and has attributes' do
      activity = Activity.new("Brunch")

      expect(activity).to be_an_instance_of(Activity)
      expect(activity.name).to eq("Brunch")
      expect(activity.participants).to eq({})
      # expect(something).to eq(expectation)
    end
  end

  describe '#add_participant(name, amount_paid)' do
    it 'something' do
      activity = Activity.new("Brunch")

      activity.add_participant("Maria", 20)
      expect(activity.participants).to eq({"Maria" => 20})

      activity.add_participant("Luther", 40)
      expect(activity.participants).to eq({"Maria" => 20, "Luther" => 40})
    end
  end

  describe '#total_cost' do
    it 'something' do
      activity = Activity.new("Brunch")

      activity.add_participant("Maria", 20)
      expect(activity.total_cost).to eq(20)

      activity.add_participant("Luther", 40)
      expect(activity.total_cost).to eq(60)
    end
  end

  describe '#split' do
    it 'something' do
      activity = Activity.new("Brunch")

      activity.add_participant("Maria", 20)
      activity.add_participant("Luther", 40)

      expect(activity.split).to eq(30)
    end
  end

  describe '#owed' do
    it 'something' do
      activity = Activity.new("Brunch")

      activity.add_participant("Maria", 20)
      activity.add_participant("Luther", 40)

      expect(activity.owed).to eq({"Maria" => 10, "Luther" => -10})
    end
  end

  describe '#payees' do
    xit 'payees' do
      activity = Activity.new("Brunch")

      activity.add_participant("Maria", 20)
      activity.add_participant("Luther", 40)

      expect(activity.payees("Maria")).to eq(["Luther"])
      expect(activity.payees("Luther")).to eq([])
    end
  end

  describe '#method' do
    it 'something' do
      activity_4 = Activity.new("Jet Skiing")
      activity_4.add_participant("Maria", 0)
      activity_4.add_participant("Luther", 0)
      activity_4.add_participant("Louis", 40)
      activity_4.add_participant("Nemo", 40)

      expect(activity_4.owed_per_payee("Maria")).to eq(10)

      activity_3 = Activity.new("Bowling")
      activity_3.add_participant("Maria", 0)
      activity_3.add_participant("Luther", 0)
      activity_3.add_participant("Louis", 30)

      expect(activity_3.owed_per_payee("Louis")).to eq(-10)
    end
  end
end

# {"Maria"=>20, "Luther"=>20, "Louis"=>-20, "Nemo"=>-20}
