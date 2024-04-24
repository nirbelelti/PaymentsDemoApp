class OrganisationFacade

  def self.create_organisation(organisation_params)
    Organisation.create!(organisation_params)
  end

  def self.update_organisation(organisation, organisation_params)
    organisation.update!(organisation_params)
  end

  def self.delete_organisation(organisation)
    organisation.destroy!
  end

  def self.find_organisation(id)
    Organisation.find(id)
  end

  def self.all_organisations
    Organisation.with_last_three_payments
  end

  def self.transfer_payment(from_organisation_id, to_organisation_id, amount)
    from_organisation = Organisation.find(from_organisation_id)
    to_organisation = Organisation.find(to_organisation_id)

    ActiveRecord::Base.transaction do
      payment = Payment.create!(organisation_id: from_organisation.id, sender_id: from_organisation.id,
                                receiver_id: to_organisation.id, amount:)
      return payment
    rescue StandardError => e
      return { error: e.message }
    end
  end

end
