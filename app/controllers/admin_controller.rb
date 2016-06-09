class AdminController < ApplicationController

  layout 'user'

  before_action :confirm_logged_in
  def home


  end

  def get_query

    @query = Query.find(params[:query_id])
    render('admin/query')

  end

  def resolve_query

    Query.destroy(params[:id])
    redirect_to(controller:'admin', action:'home')
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
end
