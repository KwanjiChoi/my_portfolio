class ApplicationController < ActionController::Base
  include Lettable

  # Dir.glob(File.join(Rails.root, 'app/controllers/concerns/define_method', '*.rb')).each do |file|
  #   file = File.basename(file, '.rb')
  #   current_module = "DefineMethod::#{file.camelize}".constantize
  #   current_module.instance_methods.each do |method|
  #     helper_method method
  #   end
  # end

  def define_helper_methods
    define_module = "DefineMethod::#{controller_name.camelize.singularize}Methods".constantize
    define_module.instance_methods.each do |method|
      ApplicationController.helper_method method
    end
  end

  def authenticate_teacher_account!
    redirect_to root_path if !current_user.teacher?
  end

  def category_list
    @categolies ||= ProjectCategory.all
  end
  helper_method :category_list
end
