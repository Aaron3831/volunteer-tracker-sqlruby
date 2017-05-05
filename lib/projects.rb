class Project
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      project = project.fetch("name")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:name => project, :id => id}))
    end
    projects
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@project}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_project|
    self.name.==(another_project.name).&(self.id.==(another_project.id))
  end
end
