class ProjectsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if params[:search]
      @projects = Project.joins(:tasks).where(['projects.description LIKE ? OR projects.name LIKE ? OR tasks.description LIKE ? OR tasks.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"])
     
    else
        @projects = Project.all.order(created_at: :desc)
    end
  
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @task = @project.tasks.build
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)

      if @project.save
        redirect_to root_path
      else
        render action: 'new'
      end
    
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
      if @project.update(project_params)
        redirect_to @project
      else
        render action: 'edit'
      end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
