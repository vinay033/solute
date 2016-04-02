class ProjectsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project, only: [:show, :edit, :update, :destroy, :invite_user]
  load_resource only: [:edit, :update, :destroy]
  # GET /projects
  # GET /projects.json
  def index
    redirect_to dashboard_path
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @task = Task.new
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.build_image
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
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

  def invite_user

    if !params["invited_user_id"].blank?
      @invitation = @project.invitations.create(invited_user_id: params["invited_user_id"])
      UserMailer.invite_user(@invitation.invited_user.email, current_user, @project).deliver_now
      respond_to do |format|
        format.js { flash[:notice] = "Invited successfully"}
      end rescue format.js { flash[:notice] = "Problems sending mail"}
    else
      respond_to do |format|
        format.js { flash[:notice] = "plese select user"}
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :submission_date, :description, :user_id, image_attributes: [:id, :avatar, :imageable_type, :imageable_id, :_destroy])
    end
end
