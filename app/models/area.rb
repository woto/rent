class Area < ApplicationRecord
  mount_uploader :spotted_map, MapUploader

  belongs_to :map
  has_many :contracts, dependent: :restrict_with_error

  include ToLabel

  validates :map, :square, :title, :ref, presence: true
  validates :square, numericality: true
  validates :ref, uniqueness: { scope: :map_id, message: "На данную область уже назначена торговая площадь." }
  validate :ref, :check_ref_integrity, if: -> {map && ref.present?}

  def today_contracts_rate
    contracts.today_in_range.sum("rate")
  end

  def today_contracts_rate_month
    contracts.today_in_range.sum("rate")*31
  end

  def update_spotted_and_dashboard_maps!
    memoized_doc.css("##{ref} *").first['style'] = 'fill: #0275D8'
    Tempfile.open(['spotted_map', '.svg']) do |temp_file|
      temp_file.write(memoized_doc.to_s)
      self.spotted_map = temp_file
      save!
    end
    map.redraw_dashboard_map!
  end

  private

  def check_ref_integrity
    found = memoized_doc.css("##{ref} *")
    errors.add(:ref, 'Отсутствует область с таким служебным номером.') if found.empty?
  end

  def memoized_doc
    @memoized_doc ||= Nokogiri::HTML::DocumentFragment.parse(File.read(map.map.file.file))
  end

end
