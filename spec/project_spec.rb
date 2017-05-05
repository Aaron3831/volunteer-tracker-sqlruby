require 'spec_helper'

describe(Project) do
  describe(".all") do
    it("starts off with no projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe("#project") do
    it("tells you its project") do
      specialty = Project.new({:project => "Cleanup", :id => nil})
      expect(specialty.project).to(eq("Cleanup"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      project = Project.new({:project => "Cleanup", :id => nil})
      project.save()
      expect(project.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save specialties to the database") do
      project = Project.new({:project => "Cleanup", :id => nil})
      project.save()
      expect(Project.all()).to(eq([project]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same project") do
      project1 = Project.new({:project => "Cleanup", :id => nil})
      project2 = Project.new({:project => "Cleanup", :id => nil})
      expect(project1).to(eq(project2))
    end
  end
end
