class Project
  attr_reader(:project, :id)

  define_method(:initialize) do |attributes|
    @project = attributes.fetch(:project)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      project = project.fetch("project")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:project => project, :id => id}))
    end
    projects
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO projects (project) VALUES ('#{@project}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_project|
    self.project.==(another_project.project).&(self.id.==(another_project.id))
  end
end
