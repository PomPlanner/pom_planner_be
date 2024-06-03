require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  before :each do
    @user1 = create(:user)
  end

  it "has a Show Page" do
    get api_v1_user_path(@user1)
        
    expect(response).to have_http_status(:success)
    expect(response.body).to include("")
  end
end