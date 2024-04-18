require "rails_helper"

RSpec.describe 'routes for Organisations', type: :routing do
  it 'CRUD routes /api/v1/organisations to via organisations controller' do
    expect(get('/api/v1/organisations')).to route_to('api/v1/organisations#index')
    expect(post('/api/v1/organisations')).to route_to('api/v1/organisations#create')
    expect(get('/api/v1/organisations/1')).to route_to('api/v1/organisations#show', id: '1')
    expect(put('/api/v1/organisations/1')).to route_to('api/v1/organisations#update', id: '1')
    expect(delete('/api/v1/organisations/1')).to route_to('api/v1/organisations#destroy', id: '1')
  end
end
