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
    Organisation.all
  end

end
