require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages) { create_list(:message, 5, user: user, group: group) }

    describe 'GET #index' do
      context 'when user is logged in' do
        before do
          login_user user
          get :index, group_id: group 
        end
   
        it "assigns the requested group to @group" do
          expect(assigns(:group)).to eq(group)
        end
           
        it "assigns the requested group to @messages" do
          expect(assigns(:messages)).to match(messages)       
        end

        it "assigns the requested contact to @groups" do
          groups = user.groups
          expect(assigns(:groups)).to match groups
        end    

        it "renders the :index template"do
          expect(response).to render_template :index
        end  
      end  

      context 'when user is logged out' do
        it 'redirects to login page'do
          get :index, group_id: group 
          expect(response).to redirect_to new_user_session_path
        end
      end  
  end
  describe 'POST #create' do

　end
end
