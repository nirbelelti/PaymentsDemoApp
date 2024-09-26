require 'rails_helper'

RSpec.describe OrganisationFacade, type: :facade do
  let!(:organisations) { FactoryBot.create_list(:organisation, 3) }
  let!(:organisation) { organisations.first }
  let(:organisation_params) { FactoryBot.attributes_for(:organisation) }

  describe '.all_organisations' do
    it 'returns all organisations' do
      expect(described_class.get_index.size).to eq(organisations.size)
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

  describe '.get_all_organisations_with_last_payments' do
    it 'transfer payments between two organisations' do
      organisations.each do|org|
        3.times do
          Payment.create!( sender: org, receiver: organisations.sample, amount: Faker::Number.decimal(l_digits: 3, r_digits: 2), status: Payment.statuses.keys.sample,vendor_id: FactoryBot.create(:vendor).id )
        end
      end
      organisations =described_class.get_all_organisations_with_last_payments
      expect(organisations.length).to eq(organisations.length)
      organisations.each do |org|
        expect(org.last_three_payments.length).to eq(3)
      end
    end
  end
end