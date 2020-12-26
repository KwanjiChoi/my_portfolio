class MaxCountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.send(options[:belongs_to].downcase).
        send(attribute.to_s.pluralize).count >= options[:count]
      record.errors[attribute] << "の登録は最大#{options[:count]}件までです"
    end
  end
end
