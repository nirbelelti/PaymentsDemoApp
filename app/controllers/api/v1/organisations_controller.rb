require_dependency 'organisation_facade'

class Api::V1::OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[show update destroy]

  def index
    @pagy, organisations = pagy(OrganisationFacade.get_index)
    render json: { organisations: organisations, metadata: pagy_metadata(@pagy) }
  end

  def payments_activity
    @pagy, organisations = pagy(OrganisationFacade.get_all_organisations_with_last_payments)
    render json: { payments: organisations, metadata: pagy_metadata(@pagy) }
  end

  def show
    render json: @organisation
  end

  def create
    org = OrganisationFacade.create_organisation(organisation_params)
    if org[:status] == :created
      render json: org[:organisation], status: :created
    else
      render json: org[:errors], status: :unprocessable_entity
    end
  end

  def update
    result = OrganisationFacade.update_organisation(@organisation, organisation_params)
    if result[:status] == :updated
      render json: { message: 'updated successfully' }, status: :ok
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  def destroy
    OrganisationFacade.delete_organisation(@organisation)
  end

  def transfer_payment
    payment = OrganisationFacade.transfer_payment(transfer_payment_params[:id],
                                                  transfer_payment_params[:to_organisation_id], transfer_payment_params[:amount])
    if payment.errors.any?
      render json: payment.errors, status: :unprocessable_entity
    else
      render json: payment, status: :created
    end
  end

  private

  def set_organisation
    @organisation = OrganisationFacade.find_organisation(params[:id])
  end

  def transfer_payment_params
    params.permit(:id, :to_organisation_id, :amount)
  end

  def organisation_params
    params.permit(:name,
                  :address,
                  :vat_id,
                  :crm_id,
                  :email,
                  :segment)
  end

end
