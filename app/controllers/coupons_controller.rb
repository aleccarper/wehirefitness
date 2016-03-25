class CouponsController < ApplicationController
  respond_to :json

  def lookup
    coupon = Coupon.find_by_code(params[:code])
    response = {}
    if coupon
      response[:found] = true
      response[:code] = coupon.code
      response[:can_use] = coupon.can_use?
      response[:percent_off] = coupon.percent_off
      response[:as_float] = coupon.as_float
    else
      response[:found] = false
    end

    render json: response
  end
end
