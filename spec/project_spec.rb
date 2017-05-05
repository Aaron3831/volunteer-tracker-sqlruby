require('spec_helper')

describe(Project) do
  describe(".all") do
    it("starts off with no projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      project = Project.new({:name => "Cleanup", :id => nil})
      expect(project.name()).to(eq("Cleanup"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      project = Project.new({:name => "Cleanup", :id => nil})
      project.save()
      expect(project.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save projects to the database") do
      project = Project.new({:name => "Cleanup", :id => nil})
      project.save()
      expect(Project.all()).to(eq([project]))
    end
  end

  describe("#==") do
    it("is the same project if it has the same name") do
      project1 = Project.new({:name => "Cleanup", :id => nil})
      project2 = Project.new({:name => "Cleanup", :id => nil})
      expect(project1).to(eq(project2))
    end
  end

  describe(".find") do
    it("returns a project by its ID") do
      test_project = Project.new({:name => "Cleanup", :id => nil})
      test_project.save()
      test_project2 = Project.new({:name => "Home stuff", :id => nil})
      test_project2.save()
      expect(Project.find(test_project2.id())).to(eq(test_project2))
    end
  end

  describe("#tasks") do
    it("returns an array of tasks for that project") do
      test_project = Project.new({:name => "Cleanup", :id => nil})
      test_project.save()
      test_task = Volunteer.new({:name => "Learn SQL", :project_id => test_project.id()})
      test_task.save()
      test_task2 = Volunteer.new({:name => "Review Ruby", :project_id => test_project.id()})
      test_task2.save()
      expect(test_project.tasks()).to(eq([test_task, test_task2]))
    end
  end

  describe('#update') do
    it('lets you update projects in the database') do
      project = Project.new({:name => "Cleanup", :id => nil})
      project.save()
      project.update({:name => "Homework Stuff"})
      expect(project.name()).to(eq("Homework Stuff"))
    end
  end
  describe("#delete") do
    it("lets you delete a project from the database") do
      project = Project.new({:name => "Cleanup", :id => nil})
      project.save()
      project2 = Project.new({:name => "House stuff", :id => nil})
      project2.save()
      project.delete()
      expect(Project.all()).to(eq([project2]))
    end
    it("deletes a project's tasks from the database") do
      project = Project.new({:name => "Cleanup", :id => nil})
      project.save()
      task = Volunteer.new({:name => "learn SQL", :project_id => project.id()})
      task.save()
      task2 = Volunteer.new({:name => "Review Ruby", :project_id => project.id()})
      task2.save()
      project.delete()
      expect(Volunteer.all()).to(eq([]))
    end
  end
end
