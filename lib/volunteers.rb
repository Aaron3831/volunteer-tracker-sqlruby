class Volunteer
  attr_reader(:name, :project_id, :id)

  define_method(:initialize) do |attributes|
    @volunteer = attributes.fetch(:volunteer)
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
      volunteers.push(Volunteer.new({:volunteer => volunteer, :project_id => project_id, :id => id}))
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
    returned_project = DB.exec("SELECT * FROM specialties WHERE volunteer = '#{project}';")
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
      volunteers_array.push(Volunteer.new({:volunteer => volunteer, :project_id => project_id, :id => id}))
    end
    volunteers_array
  end

  define_singleton_method(:patients_for_volunteer) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers ORDER BY volunteer;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      volunteer = volunteer.fetch("volunteer")
      project_id = volunteer.fetch("project_id").to_i()
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:volunteer => volunteer, :project_id => project_id, :id => id}))
    end
    volunteer_patient_array = []
    returned_volunteers.each() do |volunteer|
      id = volunteer.fetch("id").to_i()
      patients_amount = DB.exec("SELECT COUNT(name) FROM patients WHERE volunteer_id = #{id};")
      amount = patients_amount.values().join().to_s()
      name = volunteer.fetch("name")
      volunteer_patient_array.push(name + amount)
    end
    volunteer_patient_array
  end
end
