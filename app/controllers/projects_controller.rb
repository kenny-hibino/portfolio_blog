class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page])
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Awesome, your project has been successfully saved!"
      redirect_to @project 
    else
      flash[:danger] = "Oh no, something went wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] =  "Cool, you updated your project!"
      redirect_to @project
    else
      flash[:danger] = "Oh no, something went wrong"
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Successfully deleted the project"
    redirect_to projects_url
  end



  private

    def get_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :link, :slug, :image)
    end
end
