class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
    @tasks = Current.user.tasks.order(params[:sort])
      if params[:title] || params[:status]
        @tasks = Current.user.tasks.search_title_or_content( "%#{params[:title]}%" )			
        .search_status_type( "%#{params[:status]}%" )
        .order_by_created_at
      elsif params[:sort]
        @tasks = Current.user.tasks.order(params[:sort])
        @tasks = Current.user.tasks.order(params[:sort]).page(params[:page]).per(3)
      else
        @tasks = Current.user.tasks.order_by_created_at
        @tasks = Current.user.tasks.order_by_created_at.page(params[:page]).per(3)
    end
  end

  def show
    @tasks = Current.user.tasks.find(params[:id])
    render plain: "OK"
  end

  def new
    @task = Current.user.tasks.new
  end

  def edit; end
    
  def create
    @task = Current.user.tasks.new(task_params)
    
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

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :end_time, :status_type, :priority_type, :tag_list)
  end

  def find_task
    @task = Current.user.tasks.find_by(id: params[:id])
  end

  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to root_path if @task.nil?
  end
end
