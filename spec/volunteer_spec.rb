require 'spec_helper'

describe(Volunteer) do
  describe(".all") do
    it("is empty at first") do
      expect(Volunteer.all()).to(eq([]))
    end
  end

  describe("#project_id") do
    it("lets you read the project ID out") do
      test_volunteer = Volunteer.new({:volunteer => "Aaron", :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to(eq(1))
    end
  end

  describe("#save") do
    it("adds a volunteer to the array of saved volunteers") do
      test_volunteer = Volunteer.new({:volunteer => "Aaron", :project_id => 1, :id => nil})
      test_volunteer.save()
      expect(Volunteer.all()).to(eq([test_volunteer]))
    end
  end

  describe(".volunteers_in_project") do
    it("finds all volunteers that are in the project") do
      test_project = Project.new({:volunteer => "Cleanup", :id => nil})
      test_project.save()
      test_volunteer = Volunteer.new({:volunteer => "Aaron", :project_id => test_project.id, :id => nil})
      test_volunteer.save()
      expect(Volunteer.volunteers_in_project("Cleanup")).to(eq([test_volunteer]))
    end
  end
end
