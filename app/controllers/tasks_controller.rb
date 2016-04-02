class TasksController < ApplicationController
   before_action :authenticate_user!

  before_action :set_task, only: [:destroy]
  load_resource through: :current_user, only: [:destroy]
  

  def new
    
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        @task_created = true
        @project = @task.project
        format.js { flash[:notice] = "created successfully"}
      else
        format.js {}
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :due_date, :description, :project_id)
    end
end
