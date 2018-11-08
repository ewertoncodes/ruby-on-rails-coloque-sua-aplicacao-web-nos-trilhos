class Room < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :location, :description

  scope :most_recent, -> { ordeo(created_at: :desc)}

  def complete_name
    "#{title}, #{location}"
  end
end
