RSpec.describe Api::V1::BmiDataController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST /api/v1/bmi_data' do
    it 'creates a data entry' do
      post '/api/v1/bmi_data', params: {
        bmi_data: { data: { message: 'Average' } }
      }, headers: headers
      entry = BmiData.last
      expect(entry.data).to eq 'message' => 'Average'
    end
  end

  describe 'GET /api/v1/bmi_data' do
    before do
      5.times { user.bmi_data.create(data: { message: 'Average' }) }
    end
  
    it 'returns a collection of bmi data' do
      get '/api/v1/bmi_data', headers: headers
      expect(response_json['entries'].count).to eq 5
    end
  end
end