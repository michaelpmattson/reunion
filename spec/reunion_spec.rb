require './lib/reunion'
require './lib/activity'

RSpec.describe Reunion do
  describe '#initialize' do
    it 'exists and has attributes' do
      reunion = Reunion.new("1406 BE")

      expect(reunion).to be_an_instance_of(Reunion)
      expect(reunion.name).to eq("1406 BE")
      expect(reunion.activities).to eq([])
    end
  end

  describe '#add_activity(activity)' do
    it 'adds activity' do
      reunion = Reunion.new("1406 BE")
      activity_1 = Activity.new("Brunch")
      reunion.add_activity(activity_1)

      expect(reunion.activities).to eq([activity_1])
    end
  end

  describe '#total_cost' do
    it 'adds all costs' do
      reunion = Reunion.new("1406 BE")

      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)
      reunion.add_activity(activity_1)

      expect(reunion.total_cost).to eq(60)

      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)
      reunion.add_activity(activity_2)

      expect(reunion.total_cost).to eq(180)
    end
  end

  describe '#breakout' do
    it 'gives a breakout by participant' do
      reunion = Reunion.new("1406 BE")

      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)
      reunion.add_activity(activity_1)

      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)
      reunion.add_activity(activity_2)

      expect(reunion.breakout).to eq({"Maria" => -10, "Luther" => -30, "Louis" => 40})
    end
  end

  describe '#summary' do
    it 'returns the breakout as a string' do
      reunion = Reunion.new("1406 BE")

      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)
      reunion.add_activity(activity_1)

      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)
      reunion.add_activity(activity_2)

      expect(reunion.summary).to eq("Maria: -10\nLuther: -30\nLouis: 40")
    end
  end
end
