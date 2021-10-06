# frozen_string_literal: true

# Patient_controller
class Doc::PatientsController < ApplicationController
  before_action :set_patient

  def index
    @users = User.patients.where(['firstname LIKE ?', "%#{params[:search]}%"]).page(params[:page]).per(10)
  end

  def edit; end

  def update
    @patient.update(patient_params)

    if @patient.save
      redirect_to doc_users_path(@patient.user)
    else
      render :edit
    end
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:id])
  end

  def patient_params
    params.require(:patient).permit(:user_id, :medical_record, :test_results, :medications,
                                    patient_attributes: %i[firstname])
  end
end
