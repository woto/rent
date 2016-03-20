module ToLabel

  extend ActiveSupport::Concern

  def to_label
    title
  end

end

