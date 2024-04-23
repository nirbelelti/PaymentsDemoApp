require 'rails_helper'

RSpec.describe "Api::V1::Payments", type: :request do
  let!(:payments) { FactoryBot.create_list(:payment, 3) }
  let!(:payment) { payments.first }
  let!(:organisation) { payment.organisation }

  def json
    JSON.parse(response.body)
  end

  describe "GET /index" do
    before { get '/api/v1/payments' }

    it 'returns payments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    before { get "/api/v1/payments/#{payment.id}" }

    it 'returns the payment' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(payment.id)
      expect(json['organisation_id']).to eq(payment.organisation_id)
      expect(json['sender_id']).to eq(payment.sender_id)
      expect(json['receiver_id']).to eq(payment.receiver_id)
      expect(json['amount']).to eq(payment.amount)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { FactoryBot.attributes_for(:payment, organisation_id: organisation.id) }
    let(:invalid_attributes) { valid_attributes.merge(amount: nil) }

    context 'with valid attributes' do
      before { post '/api/v1/payments', params: { payment: valid_attributes } }

      it 'creates an payment' do
        # expect(json['organisation_id']).to eq(valid_attributes[:organisation_id])
        # expect(json['sender_id']).to eq(valid_attributes[:sender_id])
        # expect(json['receiver_id']).to eq(valid_attributes[:receiver_id])
        expect(json['amount']).to eq(valid_attributes[:amount])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      before { post '/api/v1/payments', params: { payment: invalid_attributes } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /update" do

    context 'with valid attributes' do
      before { patch "/api/v1/payments/#{payment.id}", params: { payment: { id: 1, sender_id: 22222 } } }

      it 'updates the payment' do
        expect(json['sender_id']).to eq(22222)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
