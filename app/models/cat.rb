# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  birth_date  :date
#

class Cat < ActiveRecord::Base
  validates :birth_date, presence: true
  validates :color, presence: true
  validates :name, presence: true
  validates :sex, presence: true
  validates :description, presence: true
  validate :sex_is_a_sex
  validate :color_is_a_color

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
  def age
    Date.today - self.birth_date
  end


  private
  def sex_is_a_sex
    ["M", "F"].include?(:sex)
  end

  def color_is_a_color
    colors = %w{brown, grey, black, orange, calico, white}
    colors.include?(:color)
  end
end
