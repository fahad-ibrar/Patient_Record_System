module Api

  class PatientController < ApplicationController
    respond_to :json


    def index
      respond_with Patient.get_all_patients
    end

    def details
      respond_with Patient.find(params[:id])
    end

    def diagnosis
      respond_with Patient.patient_diagnosis(params[:id])
    end

    def search
      respond_with Patient.search_patient(params[:firstName], params[:lastName], params[:age],params[:gender])
    end
  end
end