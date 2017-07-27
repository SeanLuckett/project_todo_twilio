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
    @task = Task.new(
      description: task_params[:description],
      due: Date.new(*flatten_date_array(params[:task])),
      state: task_params[:state]
    )

    if @task.save
      flash.notice = 'Task created'
      redirect_to task_path(@task)
    else
      flash.now[:error] = 'Could not create task'
      flash.now[:errors] = @task.errors.messages
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      flash.notice = 'Task updated'
      redirect_to tasks_path
    else
      flash.now[:error] = 'Problem with updating task'
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash.notice = 'Task destroyed'
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
