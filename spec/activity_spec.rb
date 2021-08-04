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
end
