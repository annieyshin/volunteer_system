require 'sinatra'
require 'sinatra/reloader'
require './lib/volunteer'
require './lib/project'
also_reload('lib/**/*.rb')
require 'pg'

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

get("/") do
  erb(:index)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  @projects = Project.all
  erb(:project_form)
end

post('/projects') do
  title = params["title"]
  @project = Project.new({:title => title, :id => nil})
  @project.save()
  @projects = Project.all
  erb(:projects)
end
