class PatientController < ApplicationController


  skip_before_filter :verify_authenticity_token, :only => :patient_search
  layout 'user'
  def addPatient
    render('patient/addPatient')
  end

  def create
    @patient = Patient.new(patient_params)
   if @patient.save!
      redirect_to(controller:'admin',action:'home')
   else
    render('addPatient')
  end
  end

  def deletePatients
    #Patient.destroy_all(id:params[:patient_ids])
    Patient.destroy_patients(params[:patient_ids])
    # redirect_to(action:'patientList')
    success = params[:patient_ids]
    render json: success


  end

  def patientList
    puts 'In patientList'
    #@patients = Patient.all #change patient to patients
    @patients = Patient.get_all_patients.paginate(per_page:10, page:params[:page])
     respond_to :html, :js
    # respond_to do |format|
    # format.js   { render layout: false }
    # end
  end

  def patient_search


    p = params[:patient]

    if p!=nil
       @patients = Patient.search_patient(p[:firstName],p[:lastName],p[:age],p[:gender],p[:sortBy]).paginate(per_page:10, page:params[:page])

  else

      @patients = Patient.search_patient(params[:firstName],params[:lastName],params[:age],params[:gender],params[:sortBy]).paginate(per_page:10, page:params[:page])

  end
    respond_to do |format|
      format.js {}
     end
  end

  def delete
    #Patient.destroy(params[:id])
    Patient.destroy_patient(params[:id])
    #redirect_to(action:'patientList')

    @deleted_patient = params[:id]
    respond_to do |format|
      format.js {}
     end
  end

  def profile
    @patient = Patient.find(params[:id])
    @patientHistories = @patient.histories.paginate(per_page:10, page:params[:page])
    @doctorDiagnoses = @patient.diagnoses.paginate(per_page:10, page:params[:page])
    @patientComments = @patient._comments

    # respond_to :html{render('patient')}, :js
    render('patient')

  end

  def history_load

    @patient = Patient.find(params[:id])
    @patientHistories = @patient.histories.paginate(per_page:10, page:params[:page])
    respond_to do |format|
       format.js {}
      end
  end

  def diagnosis_load

    @patient = Patient.find(params[:id])
    @doctorDiagnoses = @patient.diagnoses.paginate(per_page:10, page:params[:page])
    respond_to do |format|
       format.js {}
      end
  end


  def updatePhoto
   @patient = Patient.find(params[:id])
    @patient.update!(updatePhoto_params)
    redirect_to(action:'profile',id:params[:id])

  end

  def updatePersonalInfo
    @patient = Patient.find(params[:id])
    @patient.update!(updatePersonalInfo_params)
    redirect_to(action:'profile',id:params[:id])
  end

  def updateContactInfo
    @patient = Patient.find(params[:id])
    @patient.update!(updateContactInfo_params)
    redirect_to(action:'profile',id:params[:id])
  end

  def updateAddressInfo
    @patient = Patient.find(params[:id])
    @patient.update!(updateAddressInfo_params)
    redirect_to(action:'profile',id:params[:id])
  end

  def deleteHistory
    #PatientHistory.where(patient_id: params[:id], id:params[:history_id]).destroy_all
    PatientHistory.destroy_history(params[:history_id])
    redirect_to(action:'history_load',id:params[:id],page:params[:page])
  end

  def add_history
    @patientHistroy = PatientHistory.new(addHistory_params)
    @patientHistroy.save!
    @patient = Patient.find(params[:id])
    # params[:action] = 'history_load'
      redirect_to(action:'history_load',id:params[:id],page:params[:page])
  end

  def deleteHistories

    #PatientHistory.destroy_all(patient_id:params[:patientHistory_ids])
    PatientHistory.destroy_histories(params[:patientHistory_ids])
    redirect_to(action:'history_load',id:params[:id],page:params[:page])
  end

  def editHistory
    @patient = Patient.find(params[:id])

    #@patientHistroy = @patient.patient_histories.where(id: params[:history_id]).first
    @patientHistroy = @patient.get_history(params[:history_id])

    @patientHistroy.update!(editHistory_params)
    redirect_to(action:'history_load',id:params[:id],page:params[:page])


    # redirect_to(action:'profile',id:params[:id])


    # respond_to do |format|
    #   format.js {}
    #  end
  end

  def add_Diagnosis
    @patientDiagnosis = DoctorDiagnosis.new(addDiagnosis_params)
    @patientDiagnosis.save!
    @patient = Patient.find(params[:id])
    @doctorDiagnoses = @patient.diagnoses.paginate(per_page:10, page:params[:page])
    # params[:action] = 'history_load'
      redirect_to(action:'diagnosis_load',id:params[:id],page:params[:page])
  end



 def deleteDiagnosis
    #PatientHistory.where(patient_id: params[:id], id:params[:history_id]).destroy_all
    DoctorDiagnosis.destroy_diagnosis(params[:diagnosis_id])
    redirect_to(action:'diagnosis_load',id:params[:id],page:params[:page])
  end

  def deleteDiagnoses

    #PatientHistory.destroy_all(patient_id:params[:patientHistory_ids])
    DoctorDiagnosis.destroy_diagnoses(params[:patientDiagnosis_ids])
    redirect_to(action:'diagnosis_load',id:params[:id],page:params[:page])
  end

  def editDiagnosis
    @patient = Patient.find(params[:id])
    @patientDiagnosis = @patient.get_diagnosis(params[:diagnosis_id])

    @patientDiagnosis.update!(editDiagnosis_params)
   redirect_to(action:'diagnosis_load',id:params[:id],page:params[:page])
  end

  def deleteComment
    #PatientHistory.where(patient_id: params[:id], id:params[:history_id]).destroy_all
    Comment.destroy_comment(params[:comment_id])
    redirect_to(action:'profile',id:params[:id])
  end

  def deleteComments

    #PatientHistory.destroy_all(patient_id:params[:patientHistory_ids])
    Comment.destroy_comments(params[:patientComment_ids])
    redirect_to(action:'profile',id:params[:id])
  end

  def editComment
    @patient = Patient.find(params[:id])
    #@patientHistories = @patient.patient_histories #(params[:history_id])
    #@patientHistroy = @patient.patient_histories.where(id: params[:history_id]).first
    @patientComment = @patient.get_comment(params[:comment_id])

    @patientComment.update!(editComment_params)
    redirect_to(action:'profile',id:params[:id])
  end

  private

  def patient_params
    params.require(:patient).permit(:email,:title,:firstName,:lastName,:gender,:dob,:bloodGroup,:photo,:streetAddress,:city,:country,:phone,:photo)

  end

  def updatePhoto_params
    params.require(:patient).permit(:photo)

  end

  def updatePersonalInfo_params
    params.require(:patient).permit(:title,:firstName,:lastName,:gender,:dob)

  end

  def updateContactInfo_params
    params.require(:patient).permit(:email,:phone)

  end

  def updateAddressInfo_params
    params.require(:patient).permit(:streetAddress,:city,:country)

  end

  def editHistory_params
     params.require(:patient_history).permit(:detail)
  end

  def addHistory_params
     params.require(:patient_history).permit(:detail).merge(user_id: session[:user_id],patient_id:params[:id],date:Date.today)
  end

  def addDiagnosis_params
     params.require(:doctor_diagnosis).permit(:detail).merge(user_id: session[:user_id],patient_id:params[:id],date:Date.today)
  end

  def editDiagnosis_params
     params.require(:doctor_diagnosis).permit(:detail)
  end

  def editComment_params
     params.require(:comment).permit(:detail)
  end
end
