class Map < ApplicationRecord

  mount_uploader :map, MapUploader
  mount_uploader :dashboard_map, MapUploader

  include ToLabel

  has_many :areas, dependent: :restrict_with_error

  validates :title, presence: true
  validate :check_ref_integrity, on: :update

  def redraw_dashboard_map!
    Tempfile.open(['dashboard_map', '.svg']) do |temp_file|
      areas.each do |area|
        memoized_doc.css("##{area.ref}").first['style'] = 'fill: #008000'
      end
      temp_file.write(memoized_doc.to_s)
      self.dashboard_map = temp_file
      save!
    end
  end

  private

  def check_ref_integrity
    missing_areas = []
    areas.each do |area|
      if memoized_doc.css("##{area.ref}").empty?
        missing_areas << area.ref
      end
    end
    unless missing_areas.empty?
      errors.add(:map, "Невозможно заменить карту территории, т.к. на новой карте отсутсвуют области #{missing_areas.join(', ')}")
    end
  end

  def memoized_doc
    @memoized_doc ||= Nokogiri::HTML::DocumentFragment.parse(File.read(map.file.file))
  end

end
