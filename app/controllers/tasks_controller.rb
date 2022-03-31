class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.order(params[:sort])
      if params[:title] || params[:status]
        @tasks = Task.search_title_or_content( "%#{params[:title]}%" )			
        .search_status_type( "%#{params[:status]}%" )
        .order_by_created_at
      elsif params[:sort]
        @tasks = Task.order(params[:sort])
      else
        @tasks = Task.order_by_created_at
    end
  end

  def show
    @tasks = Task.find(params[:id])
    render plain: "OK"
  end

  def new
    @task = Task.new
  end

  def edit; end
    
  def create
    @task = Task.new(task_params)
    
    if @task.save
      redirect_to tasks_path, notice: I18n.t(:task_add_success_template)
    else
      render :new
    end
  end
    
  def update
    if @task.update(task_params)
        redirect_to tasks_path, notice: I18n.t(:task_update_success_template)
    else
        render :edit
    end
  end

  def destroy
    @task.destroy if @task
    redirect_to tasks_path, alert: I18n.t(:task_delete_success_template)
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :end_time, :status_type, :priority_type)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
