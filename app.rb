require 'sinatra'
require 'sinatra/reloader'
require './lib/volunteer'
require './lib/project'
also_reload('lib/**/*.rb')
require 'pg'

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

get("/") do
  @projects = Project.all
  erb(:index)
end


post('/') do
  title = params["title"]
  @project = Project.new({:title => title, :id => nil})
  @project.save()
  @projects = Project.all
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i())
  @volunteers = Volunteer.all
  erb(:project_edit)
end

get('/projects/edit') do
  @project = Project.find(params.fetch("id").to_i())
  @projects = Project.all()
  @volunteers = Volunteer.all
  erb(:project_edit)
end

get("/projects/:id/edit") do
  @project = Project.find(params.fetch("id").to_i())
  @projects = Project.all()
  @volunteers = Volunteer.all
  erb(:project_edit)
end

patch("/projects/:id") do
  title = params.fetch("title")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  redirect("/")
end

delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:index)
end

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:volunteers)
end

get('/volunteers/add') do
  @volunteers = Volunteer.all
  erb(:volunteer_form)
end


post('/volunteers') do
  name = params["name"]
  project_id = params.fetch("project_id").to_i
  @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  @volunteer.save()
  @volunteers = Volunteer.all
  erb(:volunteers)
end
