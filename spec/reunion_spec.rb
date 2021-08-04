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
end
