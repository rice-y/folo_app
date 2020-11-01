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
    @project = ProjectsTag.new
  end

  # GET /projects/1/edit
  def edit

    @project = ProjectsTag.new(project: @project)
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = ProjectsTag.new(project_params)

      if @project.valid? 
        @project.save
        return redirect_to root_path
      else
        render action: 'new'
      end
    
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update

    @project = ProjectsTag.new(project_params,project:@project)

      if  @project.update
        
        return redirect_to project_path
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
      params.require(:projects_tag).permit(:name, :description, :title).merge(user_id: current_user.id)
    end
    
    
end
