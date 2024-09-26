require 'rails_helper'

RSpec.describe "Api::V1::Organisations", type: :request do
  let!(:organisations) { FactoryBot.create_list(:organisation, 3) }
  let!(:organisation) { organisations.first }

  def json
    JSON.parse(response.body)
  end

  describe "GET /index" do
    before { get '/api/v1/organisations' }

    it 'returns organisations' do
      expect(json).not_to be_empty
      expect(json.length).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    before { get "/api/v1/organisations/#{organisation.id}" }

    it 'returns the organisation' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(organisation.id)
      expect(json['name']).to eq(organisation.name)
      expect(json['uuid']).to eq(organisation.uuid)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { FactoryBot.attributes_for(:organisation) }
    let(:invalid_attributes) { valid_attributes.merge(name: nil)}

    context 'with valid attributes' do
      before { post '/api/v1/organisations', params: valid_attributes }

      it 'creates an organisation' do
        expect(json['name']).to eq(valid_attributes[:name])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
        before { post '/api/v1/organisations', params: invalid_attributes  }
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
  end

  describe "PATCH /update" do
    let(:valid_attributes) { { name: 'New Name' } }

    context 'with valid attributes' do
      before { patch "/api/v1/organisations/#{organisation.id}", params:  valid_attributes }

      it 'updates the organisation' do
        expect(json['message']).to eq('updated successfully')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end
