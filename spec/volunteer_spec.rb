require('spec_helper')

describe(Volunteer) do
  describe(".all") do
    it("is empty at first") do
      expect(Volunteer.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a volunteer to the array of saved volunteers") do
      test_volunteer = Volunteer.new({:name => "bob", :list_id => 1})
      test_volunteer.save()
      expect(Volunteer.all()).to(eq([test_volunteer]))
    end
  end

  describe("#name") do
    it("lets you read the name out") do
      test_volunteer = Volunteer.new({:name => "bob", :list_id => 1})
      expect(test_volunteer.name()).to(eq("bob"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_volunteer = Volunteer.new({:name => "bob", :list_id => 1})
      expect(test_volunteer.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same volunteer if it has the same name and list ID") do
      volunteer1 = Volunteer.new({:name => "bob", :list_id => 1})
      volunteer2 = Volunteer.new({:name => "bob", :list_id => 1})
      expect(volunteer1).to(eq(volunteer2))
    end
  end
end
