module Lettable
  extend ActiveSupport::Concern

  class_methods do
    def let(name, &blk)
      variable = "@#{name}"
      define_method name do
        return instance_variable_get(variable) if instance_variable_defined?(variable)
        instance_variable_set(variable, instance_eval(&blk))
      end
      helper_method name

      define_method :"#{name}=" do |value|
        instance_variable_set(variable, value)
      end
      private :"#{name}="
    end
  end
end
