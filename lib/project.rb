class Project
  attr_reader(:title)

  def initialize(attributes)
    @title = attributes.fetch(:title)
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      projects.push(Project.new({:title => title}))
    end
    projects
  end
      
