class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    @tasks = Task.find(params[:id])
    render plain: "OK"
  end

  def new
    @task = Task.new
  end

  def edit
  end
    
  def create
    @task = Task.new(task_params)
    
    if @task.save
      # 成功
      redirect_to tasks_path, notice: I18n.t(:新增任務成功樣版)
    else
      # 失敗
      render :new
    end
  end
    
  def update
    if @task.update(task_params)
        # 成功
        redirect_to tasks_path, notice: I18n.t(:資料更新成功樣版)
    else
        # 失敗
        render :edit
    end
  end

  def destroy
    @task.destroy if @task
    redirect_to tasks_path, alert: I18n.t(:任務資料已刪除樣版)
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
