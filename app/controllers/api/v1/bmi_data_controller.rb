class Api::V1::BmiDataController < ApplicationController
  before_action :authenticate_api_v1_user!
  
  def index
    @collection = current_api_v1_user.bmi_data
    render json: { entries: @collection }
  end

  def create
    @data = BmiData.new(bmi_data_params.merge(user: current_api_v1_user))

    if @data.save
      render json: { message: 'all good' }
    else
      render json: { error: @data.errors.full_messages }
    end
  end
  
  private

  def bmi_data_params
    params.require(:bmi_data).permit!
  end
end