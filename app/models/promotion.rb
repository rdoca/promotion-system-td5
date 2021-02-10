class Promotion < ApplicationRecord
  has_many :coupons
  has_one :promotion_approval #busca sempre ultimo no DB
  belongs_to :user

  validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
  validates :code, uniqueness: true

  def generate_coupons!
    Coupon.transaction do
      (1..coupon_quantity).each do |number|
        coupons.create!(code: "#{code}-#{'%04d' % number}")
      end
    end
  end

  def approve!(approval_user)
    PromotionApproval.
  end


  def approver
    promotion_approval.user
    # PromotionApproval.find_by(promotion: self)
  end

end