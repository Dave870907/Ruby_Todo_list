class TasksController < ApplicationController
    before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]

    def index

        @q = current_user.tasks.ransack(params[:q])
        @tasks = @q.result
        @tasks = @tasks.order(id: :ASC).page(params[:page]).per(9)

    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.new(task_params)


        if @task.save
            flash[:notice] = I18n.t('notice.new')
            redirect_to tasks_path
            
        else
            flash[:notice] = @task.errors.full_messages.to_sentence
            render :new
        end
    end
    def edit
        @task = Task.find_by(id: params[:id])
    end
    
    def destroy
        @task = Task.find_by(id: params[:id])
        @task.destroy if @task
        redirect_to tasks_path, notice: I18n.t('notice.delete')
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.update(task_params)
            redirect_to tasks_path
            flash[:notice] = I18n.t('notice.update')
        else
            flash[:notice] = @task.errors.full_messages.to_sentence
            render :edit
        end
    end
    private
    def task_params
        params.require(:task).permit(:title,:start_time,:end_time,
                                    :status,:content,:order,{ label_items: [] } )
    end    


end
