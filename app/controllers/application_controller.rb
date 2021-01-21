class ApplicationController < ActionController::Base
  include Lettable

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path
  end

  def define_helper_methods
    define_module = "DefineMethod::#{controller_name.camelize.singularize}Methods".constantize
    define_module.instance_methods.each do |method|
      # helper_methodはextendしたクラスメソッド
      ApplicationController.helper_method method
    end
  end

  def authenticate_teacher_account!
    redirect_to root_path if !current_user.teacher?
  end
end
