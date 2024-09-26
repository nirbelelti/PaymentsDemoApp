require 'rails_helper'

RSpec.describe 'Api::V1::Payments', type: :request do
  let!(:payments) { FactoryBot.create_list(:payment, 40) }
  let!(:organisation) { FactoryBot.create(:organisation) }
  let!(:vendor) { FactoryBot.create(:vendor) }
  let!(:payment) { payments.first }
  let!(:sender) { payment.sender }
  let!(:reciver) { payments.last.receiver }

  def json
    JSON.parse(response.body)
  end

  describe 'GET /index' do
    before { get '/api/v1/payments' }

    it 'returns payments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(json['payments'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'it paginating the results and returns page metadata' do
      expect(json['metadata']).not_to be_empty
      expect(json['metadata']['page']).to eq(1)
      expect(json['metadata']['next']).to eq(2)
      expect(json['metadata']['last']).to eq(2)
      expect(json['metadata']['count']).to eq(40)
      expect(json['metadata']['items']).to eq(20)
    end

    it 'filters the results by organisation_id' do
      get '/api/v1/payments', params: { organisation_id: sender.id }
      expect(json['payments'].size).to be > 0
      expect(json['payments'].size).to be < payments.size
      json['payments'].each do |payment|
        expect(payment['sender_id'] == sender.id || payment['receiver_id'] == sender.id).to be true
      end
    end
  end

  describe 'GET /show' do
    before { get "/api/v1/payments/#{payment.id}" }

    it 'returns the payment' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(payment.id)
      expect(json['sender_id']).to eq(payment.sender_id)
      expect(json['receiver_id']).to eq(payment.receiver_id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) { { sender_uuid: organisation.uuid, receiver_uuid: organisation.uuid, vendor_uuid: vendor.uuid, amount: 1 } }
    let(:invalid_attributes) { valid_attributes.merge(amount: nil) }

    context 'with valid attributes' do
      before { post '/api/v1/payments', params: valid_attributes }

      it 'creates an payment' do
        expect(json['status']).to eq('success')
        expect(json['message']).to eq('Payment processed successfully')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      before { post '/api/v1/payments', params: invalid_attributes }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /refund' do

    context 'with valid request' do
      before do
        payment.sender.update(balance: 100000)
        payment.receiver.update(balance: 100000)
      end

      it 'returns refund payment' do
        post "/api/v1/payments/#{payment.id}/refund"
        expect(json['status']).to eq('success')
        expect(json['message']).to eq('Payment processed successfully')
        payment.reload
        expect(payment.status).to eq('refunded')
      end

      it 'does not refund payment to times' do
        post "/api/v1/payments/#{payment.id}/refund"
        payment.reload
        post "/api/v1/payments/#{payment.id}/refund"
        expect(json['status']).to eq('failed')
        expect(json['message']).to eq('Payment already refunded')
      end
    end
  end
end
