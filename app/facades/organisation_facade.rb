class OrganisationFacade
  def self.create_organisation(organisation_params)
    organisation = Organisation.new(organisation_params)
    organisation.uuid = SecureRandom.uuid
    if organisation.valid?
      organisation.save!
      { organisation: organisation, status: :created }
    else
      { errors: organisation.errors, status: :unprocessable_entity }
    end
  end

  def self.update_organisation(organisation, organisation_params)
    if  organisation.update(organisation_params)
      { organisation: organisation, status: :updated }
    else
      { errors: organisation.errors, status: :unprocessable_entity }
    end
  end

  def self.delete_organisation(organisation)
    if organisation.destroy!
      { status: :deleted }
    else
      { errors: organisation.errors, status: :unprocessable_entity }
    end
  end

  def self.find_organisation(id)
    Organisation.find(id)
  end

  def self.get_index
    Organisation.all
  end

  def self.get_all_organisations_with_last_payments
    Organisation.with_last_three_payments
  end

end
