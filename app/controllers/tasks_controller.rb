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
      due: Date.new(*flatten_date_array(params[:task]))
    )

    if task.save
      redirect_to task_path(task)
    end
  end

  private

  def flatten_date_array(hash)
    %w(1 2 3).map { |n| hash["due(#{n}i)"].to_i }
  end

  def task_params
    params.require(:task).permit(:description, :due, :state)
  end
end
