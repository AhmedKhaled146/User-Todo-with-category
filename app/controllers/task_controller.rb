class TaskController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category
    before_action :set_task, only: [:show, :update, :destroy]

    # GET /categories/:category_id/tasks
    def index
      @tasks = @category.tasks.page(params[:page]).per(9)
      # puts @tasks.count
      # render json: @tasks, meta: pagination_meta(@tasks)

      render json: {
        tasks: @tasks,
        message: "all tasks in category #{@category.name}",
        count: @tasks.count
      }

    end

    # GET /categories/:category_id/tasks/:id
    def show
      render json: @task
    end

    # GET /categories/:category_id/tasks/new
    def new
      @task = @category.tasks.build
    end

    # POST /categories/:category_id/tasks
    def create
      @task = @category.tasks.build(task_params)
      @task.user = current_user
      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end


    # PUT /categories/:category_id/tasks/:id
    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    # DELETE /categories/:category_id/tasks/:id
    def destroy
      if @task.destroy
        render json: "#{@task.title} Task Was Deleted"
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    private

    def pagination_meta(task)
      {
        current_page: task.current_page,
        next_page: task.next_page,
        prev_page: task.prev_page,
        total_pages: task.total_pages,
        total_count: task.total_count
      }
    end

    def set_category
      @category = current_user.categories.find(params[:category_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Category not found" }, status: :not_found
    end

    def set_task
      @task = @category.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Task not found" }, status: :not_found
    end

    def task_params
      params.require(:task).permit(:title, :body, :is_active)
    end

end
