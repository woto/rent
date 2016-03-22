class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :ransack_params

  private

  def ransack_params
    params.require(:q).permit! if params[:q]
  end
end
