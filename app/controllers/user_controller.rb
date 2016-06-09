class UserController < ApplicationController


 layout :custom_layout
 before_filter :confirm_logged_in, :only => :profile

  def signup
    if(session[:user_id])
       redirect_to(action:'profile', id: session[:user_id])

    elsif params[:type] == '0' || params[:type] == '1'
      @departments = Department.get_all_departments
      @user = User.new(userType: params[:type])
      render('user/signup')

    else
      redirect_to(action:'login')
    end
  end

  def login
    if(session[:user_id])

      if(session[:user_type]==0)
      redirect_to(controller: 'admin',action:'home')

    elsif(session[:user]==1)

    end
    end

  end
  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.with_email(params[:email])
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      flash[:loginError]=""
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      session[:user_type] = authorized_user.userType
      session[:verify_status] = authorized_user.verifyStatus

      if session[:profileVisit] == 2
        session[:profileVisit] = nil
        redirect_to(action:'profile', id: session[:user_id])

      elsif session[:profileVisit] == 1
        session[:profileVisit] = nil
        redirect_to(action:'profile',id: session[:user_id])

      elsif authorized_user.verifyStatus == false

        redirect_to(action:'verify')

      else
        puts 'user check'
        puts authorized_user.userType
        if authorized_user.userType == 0
          puts 'in ok'
          redirect_to(controller:'admin', action:'home')
        elsif(authorized_user.userType == 1)
          redirect_to(controller:'doctor', action:'home')
        end

      end

    else
      flash[:loginError]="Invalid Email and Password Combination."
      redirect_to(action: 'login')

    end
  end

  def logout
    session[:user_id] = nil
    session[:email] = nil
    session[:user_type] = nil
    session[:verify_status] = nil
    session[:profileVisit] = nil
    session[:verificationToken] = nil
    redirect_to(action:'login')
  end

  def create
   @departments = Department.get_all_departments
   @user = User.new(user_params)
   @user.userType = params[:type]
   require 'securerandom'
   @user.verifyToken = SecureRandom.uuid
   @user.firstName.titlecase
   @user.lastName.titlecase
   @user.email.downcase
   @user.designation.titlecase
   @user.city.titlecase
   @user.country.titlecase

    if @user.save!
      UserMailer.signup_confirmation(@user).deliver_now
      found_user = User.with_email(@user.email)
      session[:user_id] = found_user.id
      session[:email] = found_user.email
      session[:user_type] = found_user.userType
      session[:verify_status] = false
      session[:verificationToken] = found_user.verifyToken
      redirect_to(action:'verify')

    else

      render('signup')
    end
  end

  def profile
    if session[:verify_status] == false && params[:id].to_i == session[:user_id]

      @user = User.find(session[:user_id])

      puts @user.email
      if @user.verifyToken == params[:token] || @user.verifyToken == session[:verificationToken]
        puts 'in update'
        @user.verifyStatus = true
        @user.verifyToken = nil
        puts @user.save!
        session[:verify_status] = true
      end

      @dept = @user.department_name
      @departments = Department.get_all_departments
      render('user/profile')

    else
      puts 'in standard'
      @user = User.find(session[:user_id])
      @dept = @user.department_name
      @departments = Department.get_all_departments
      render('user/profile')
    end
  end

  def update_personal_info
    @user = User.find(session[:user_id])
    @user.update!(updatePersonalInfo_params)
    # redirect_to(action:'profile')
    respond_to do |format|
    format.js   { render layout: false }
    end
  end

  def updateWorkInfo
    @user = User.find(session[:user_id])
    # @dept = @user.department.name

    @user.update!(updateWorkInfo_params)
    redirect_to(action:'profile')
  end

  def updateContactInfo
    @user = User.find(session[:user_id])
    @user.update!(updateContactInfo_params)
    redirect_to(action:'profile')
  end

  def update_status_photo

    @user = User.find(session[:user_id])
    @user.update!(updateStatusPhoto_params)
    redirect_to(action:'profile')

   # respond_to do |format|
   #    format.js   { render layout: false }
   #    format.html   { redirect_to root_path }
   #  end

  end

  def update_about

    @user = User.find(session[:user_id])
    @user.update!(updateAbout_params)
    respond_to do |format|
      format.js   { render layout: false }
    end
  end

  def query_list

    if session[:user_type] ==1
    @query_list = Query.doctor_queries(session[:user_id]).paginate(per_page:10, page:params[:page])
    elsif session[:user_type] ==0
    @query_list = Query.all_queries().paginate(per_page:10, page:params[:page])
    end

    render('user/queryList')

  end


   private

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:firstName,:lastName,:gender,:dob,:department_id,:designation,:specialization,:streetAddress,:city,:country,:phone,:about,:photo)

  end

   def updatePersonalInfo_params
    params.require(:user).permit(:firstName,:lastName,:gender,:dob,:streetAddress,:city,:country)

  end

  def updateWorkInfo_params
    params.require(:user).permit(:department_id,:designation)

  end

  def updateContactInfo_params
    params.require(:user).permit(:phone)

  end

  def updateStatusPhoto_params
    params.require(:user).permit(:photo,:status)

  end

  def updateAbout_params
    params.require(:user).permit(:about)

  end

  def confirm_logged_in
    unless session[:user_id]
      tempUser = User.find(params[:id])
      if !tempUser
        session[:profileVisit] = 0 #0 = user not exists
        redirect_to(action:'login')
        return false

      elsif(tempUser.verifyStatus)
        session[:profileVisit] = 1 #1 = normal visit
        redirect_to(action:'login')
        return false

      elsif(!tempUser.verifyStatus)
        if(tempUser.verifyToken == params[:token])
          session[:profileVisit] = 2 #2 = visit with verification
          session[:verificationToken] = params[:token]
          redirect_to(action:'login')
          return false
        else
           session[:profileVisit] = 3 #3 = visit without verification
           redirect_to(action:'login')
          return false
        end
      end
    else

      return true

    end

  end

  def custom_layout
    # Check if logged in, because current_user could be nil.
    if params[:action]=='profile'
      'user'
    else
      'application'
    end

  end

end
