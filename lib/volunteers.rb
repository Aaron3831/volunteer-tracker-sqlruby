class Volunteer
  attr_reader(:name, :project_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      volunteer = volunteer.fetch("volunteer")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => volunteer, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO volunteers (volunteer, project_id) VALUES ('#{@volunteer}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_volunteer|
    self.volunteer.==(another_volunteer.volunteer).&(self.id.==(another_volunteer.id))
  end

  define_singleton_method(:volunteers_in_project) do |project_volunteer|
    project = project_volunteer
    returned_project = DB.exec("SELECT * FROM projects WHERE name = '#{project}';")
    project_id = nil
    returned_project.each() do |project|
      project_id = project.fetch("id").to_i()
    end
    volunteers_list = DB.exec("SELECT * FROM volunteers WHERE project_id = #{project_id};")
    volunteers_array = []
    volunteers_list.each() do |volunteer|
      volunteer = volunteer.fetch("volunteer")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer.fetch("id").to_i()
      volunteers_array.push(Volunteer.new({:name => volunteer, :project_id => project_id, :id => id}))
    end
    volunteers_array
  end

  define_singleton_method(:projects_for_volunteer) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers ORDER BY volunteer;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      volunteer = volunteer.fetch("volunteer")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => volunteer, :project_id => project_id, :id => id}))
    end
    volunteer_project_array = []
    returned_volunteers.each() do |volunteer|
      id = volunteer.fetch("id").to_i()
      projects_amount = DB.exec("SELECT COUNT(name) FROM projects WHERE volunteer_id = #{id};")
      amount = projects_amount.values().join().to_s()
      name = volunteer.fetch("name")
      volunteer_project_array.push(name + amount)
    end
    volunteer_project_array
  end
end
