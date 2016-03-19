module ToLabel

  extend ActiveSupport::Concern

  def to_label
    title.present? ? title : "Без имени №#{id}"
  end

end

