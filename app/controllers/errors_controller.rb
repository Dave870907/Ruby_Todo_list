class ErrorsController < ApplicationController

    def not_found
        render :not_found
    end

    def internal_server_error
        render :internal_server_error
    end
end
