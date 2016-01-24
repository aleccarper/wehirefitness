class SeekersController < ApplicationController

  def create
    response = {}

    seeker = Seeker.new(seeker_params)
    if seeker.save
      response[:success] = true
      params[:categories].each do |id|
        seeker.job_notifications.create(category_id: id)
      end
    else
      response[:success] = false
      response[:errors] = seeker.errors.full_messages
    end
    render json: response
  end

  private

  def seeker_params
    params.require(:seeker).permit(:name, :email, :city, :state, :radius)
  end
end
