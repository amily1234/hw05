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
          redirect_to tasks_path, notice: "新增任務成功!"
        else
          # 失敗
          render :new
        end
    end
    
    def update
      if @task.update(task_params)
        # 成功
        redirect_to tasks_path, notice: "資料更新成功!"
      else
        # 失敗
        render :edit
      end
    end

    def destroy
      @task.destroy if @task
      redirect_to tasks_path, alert: "任務資料已刪除!"
    end

    private
      def task_params
        params.require(:task).permit(:title, :content)
      end

      def find_task
        @task = Task.find(id: params[:id])
      end
end
