class TasksController < ApplicationController


    def index
        if current_user
            @q = current_user.tasks.ransack(params[:q])
            @tasks = @q.result
            @tasks = @tasks.order(id: :ASC).page(params[:page]).per(9)
        end
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        @task.user_id = current_user.id if current_user


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
                                    :status,:content,:order,:category,:user_id )
    end    


end
