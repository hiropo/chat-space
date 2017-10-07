require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  # userをcreateし、let内に格納

    describe 'GET #index' do
      before do
        login_user user
        # controller_macros.rb内のlogin_userメソッドを呼び出し
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index        
      end
  end
end


# describe MessagesController do
#   describe 'GET #index' do
#     it "assigns the requested tweet to @group" do
#       # group = create (:group)
#      #  get :index , id: group
#     end    

#   end

#   describe 'POST #create' do
#     it "renders the :create template" do
#     end
#   end  
# end