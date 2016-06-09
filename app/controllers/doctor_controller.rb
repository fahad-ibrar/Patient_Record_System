class DoctorController < ApplicationController

  layout 'user'

  before_action :confirm_logged_in
  def home


  end

  def submit_query
    query = Query.new(query_params)
    if query.save!

      redirect_to(controller:doctor, action:home)

    end
  end

  def get_query

    @query = Query.find(params[:query_id])
    render('doctor/query')

  end


  private

  def confirm_logged_in
    unless session[:user_id]
      redirect_to(controller:'user',action:'login')
      return false
    else

      return true

    end

  end

  def query_params
    params.require(:query).permit(:subject,:message).merge(user_id: session[:user_id])
  end

end
