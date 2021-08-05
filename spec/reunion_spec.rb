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

  describe '#detailed_breakout' do
    it 'returns a hash of names as keys' do
      reunion = Reunion.new("1406 BE")

      # One person owes one person
      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)

      # One person owes two people
      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)

      # Two people owe one person
      activity_3 = Activity.new("Bowling")
      activity_3.add_participant("Maria", 0)
      activity_3.add_participant("Luther", 0)
      activity_3.add_participant("Louis", 30)

      # Two people owe two people
      activity_4 = Activity.new("Jet Skiing")
      activity_4.add_participant("Maria", 0)
      activity_4.add_participant("Luther", 0)
      activity_4.add_participant("Louis", 40)
      activity_4.add_participant("Nemo", 40)

      reunion.add_activity(activity_1)
      reunion.add_activity(activity_2)
      reunion.add_activity(activity_3)
      reunion.add_activity(activity_4)

      expect(reunion.detailed_breakout).to be_a(Hash)
      expect(reunion.detailed_breakout.keys).to eq(["Maria", "Luther", "Louis", "Nemo"])
    end

    it 'text' do
      reunion = Reunion.new("1406 BE")

      # One person owes one person
      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)

      # One person owes two people
      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)

      # Two people owe one person
      activity_3 = Activity.new("Bowling")
      activity_3.add_participant("Maria", 0)
      activity_3.add_participant("Luther", 0)
      activity_3.add_participant("Louis", 30)

      # Two people owe two people
      activity_4 = Activity.new("Jet Skiing")
      activity_4.add_participant("Maria", 0)
      activity_4.add_participant("Luther", 0)
      activity_4.add_participant("Louis", 40)
      activity_4.add_participant("Nemo", 40)

      reunion.add_activity(activity_1)
      reunion.add_activity(activity_2)
      reunion.add_activity(activity_3)
      reunion.add_activity(activity_4)

      maria_jet_skiiing = reunion.detailed_breakout["Maria"][3]
      expect(maria_jet_skiiing[:payees]).to eq(["Louis", "Nemo"])

      louis_bowling = reunion.detailed_breakout["Louis"][1]
      expect(louis_bowling[:payees]).to eq(["Maria", "Luther"])
    end

    it 'text' do
      reunion = Reunion.new("1406 BE")

      # One person owes one person
      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)

      # One person owes two people
      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)

      # Two people owe one person
      activity_3 = Activity.new("Bowling")
      activity_3.add_participant("Maria", 0)
      activity_3.add_participant("Luther", 0)
      activity_3.add_participant("Louis", 30)

      # Two people owe two people
      activity_4 = Activity.new("Jet Skiing")
      activity_4.add_participant("Maria", 0)
      activity_4.add_participant("Luther", 0)
      activity_4.add_participant("Louis", 40)
      activity_4.add_participant("Nemo", 40)

      reunion.add_activity(activity_1)
      reunion.add_activity(activity_2)
      reunion.add_activity(activity_3)
      reunion.add_activity(activity_4)

      maria_jet_skiiing = reunion.detailed_breakout["Maria"][3]
      expect(maria_jet_skiiing[:amount]).to eq(10)

      louis_bowling = reunion.detailed_breakout["Louis"][1]
      expect(louis_bowling[:amount]).to eq(-10)
    end

    it 'gives a big old hash' do
      reunion = Reunion.new("1406 BE")

      # # One person owes one person
      activity_1 = Activity.new("Brunch")
      activity_1.add_participant("Maria", 20)
      activity_1.add_participant("Luther", 40)

      # One person owes two people
      activity_2 = Activity.new("Drinks")
      activity_2.add_participant("Maria", 60)
      activity_2.add_participant("Luther", 60)
      activity_2.add_participant("Louis", 0)

      # Two people owe one person
      activity_3 = Activity.new("Bowling")
      activity_3.add_participant("Maria", 0)
      activity_3.add_participant("Luther", 0)
      activity_3.add_participant("Louis", 30)

      # Two people owe two people
      activity_4 = Activity.new("Jet Skiing")
      activity_4.add_participant("Maria", 0)
      activity_4.add_participant("Luther", 0)
      activity_4.add_participant("Louis", 40)
      activity_4.add_participant("Nemo", 40)

      reunion.add_activity(activity_1)
      reunion.add_activity(activity_2)
      reunion.add_activity(activity_3)
      reunion.add_activity(activity_4)

      expectation = {
        "Maria" => [
          {
            activity: "Brunch",
            payees: ["Luther"],
            amount: 10
          },
          {
            activity: "Drinks",
            payees: ["Louis"],
            amount: -20
          },
          {
            activity: "Bowling",
            payees: ["Louis"],
            amount: 10
          },
          {
            activity: "Jet Skiing",
            payees: ["Louis", "Nemo"],
            amount: 10
          }
        ],
        "Luther" => [
          {
            activity: "Brunch",
            payees: ["Maria"],
            amount: -10
          },
          {
            activity: "Drinks",
            payees: ["Louis"],
            amount: -20
          },
          {
            activity: "Bowling",
            payees: ["Louis"],
            amount: 10
          },
          {
            activity: "Jet Skiing",
            payees: ["Louis", "Nemo"],
            amount: 10
          }
        ],
        "Louis" => [
          {
            activity: "Drinks",
            payees: ["Maria", "Luther"],
            amount: 20
          },
          {
            activity: "Bowling",
            payees: ["Maria", "Luther"],
            amount: -10
          },
          {
            activity: "Jet Skiing",
            payees: ["Maria", "Luther"],
            amount: -10
          }
        ],
        "Nemo" => [
          {
            activity: "Jet Skiing",
            payees: ["Maria", "Luther"],
            amount: -10
          }
        ]
      }

      expect(reunion.detailed_breakout).to eq(expectation)
    end
  end
end
