class LabelsController < ApplicationController
    def index
        @labels = Label.all.page(params[:page]).per(9)
    end
    def new
        @label = Label.new
    end
    def create
        @label= Label.new(label_params)

        if @label.save
            flash[:notice] = I18n.t('notice.new')
            redirect_to labels_path
            
        else
            flash[:notice] = @label.errors.full_messages.to_sentence
            render :new
        end
    end

    def destroy
        @label = Label.find_by(id: params[:id]).destroy
        redirect_to labels_path, notice: I18n.t('notice.delete')
    end

    private

    def label_params
        params.require(:label).permit(:name)
    end
end
