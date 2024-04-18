require 'rails_helper'

RSpec.describe OrganisationFacade, type: :facade do
  let!(:organisations) { FactoryBot.create_list(:organisation, 3) }
  let!(:organisation) { organisations.first }
  let(:organisation_params) { FactoryBot.attributes_for(:organisation) }

  describe '.all_organisations' do
    it 'returns all organisations' do
      expect(described_class.all_organisations.to_a).to eq([organisation])
    end
  end

  describe '.find_organisation' do
    it 'returns the organisation' do
      expect(described_class.find_organisation(organisation.id)).to eq(organisation)
    end
  end

  describe '.create_organisation' do
    it 'creates a new organisation' do
      expect { described_class.create_organisation(organisation_params) }.to change(Organisation, :count).by(1)
    end
  end

  describe '.update_organisation' do
    it 'updates the organisation' do
      described_class.update_organisation(organisation, organisation_params)
      organisation.reload
      expect(organisation.name).to eq(organisation_params[:name])
    end
  end

  describe '.delete_organisation' do
    it 'deletes the organisation' do
      described_class.delete_organisation(organisation)
      expect(Organisation.exists?(organisation.id)).to be_falsey
    end
  end
end