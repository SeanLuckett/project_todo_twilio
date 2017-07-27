class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      description: task_params[:description],
      due: Date.new(*flatten_date_array(params[:task])),
      state: params[:state]
    )

    if task.save
      redirect_to task_path(task)
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  private

  def flatten_date_array(hash)
    %w(1 2 3).map { |n| hash["due(#{n}i)"].to_i }
  end

  def task_params
    params.require(:task).permit(:description, :due, :state)
  end
end
