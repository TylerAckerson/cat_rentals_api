class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date,  presence: true
  validates :status, presence: true
  validate :no_approved_overlapping_requests

  after_initialize :status_pending

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def approve!
    self.status = "APPROVED"
  end

  def deny!
    self.status = "DENIED"
  end

  private
  def status_pending
    self.status ||= "PENDING"
  end

  def no_approved_overlapping_requests
    unless overlapping_requests.none? { |request| request.status == "APPROVED" }
      errors[:overlapping_requests] << "There is an approved overlapping request!"
    end
  end

  def overlapping_requests
    other_requests = CatRentalRequest.where(cat_id: self.cat_id)

    other_requests.select do |request|
      (request.start_date..request.end_date).include?(self.start_date)
    end
  end

end
