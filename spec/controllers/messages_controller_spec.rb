require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages) { create_list(:message, 5, user: user, group: group) }
  let(:error_message) { { text: "", image: ""} }

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

      context 'when message is inserted'
        before do 
          login_user user
        end
        it "message is inserted in the database" do
           expect{ post :create, params: { message: attributes_for(:message), user_id: user, group_id: group} }.to change(Message, :count).by(1)
        end
        it "message is inserted and redirect to group_messages_path" do
          post :create, params: { message: attributes_for(:message), user_id: user, group_id: group }
          expect(response).to redirect_to group_messages_path
        end        


      context "when message is NOT inserted" do
        before do
          login_user user
        end
        it "meesage is NOT inserted in the database" do
           expect{ post :create, params: { message: error_message, group_id: group } }.not_to change(Message, :count)
        end
       
        it "message is NOT inserted and renders the :index template" do
           post :create, params: { message: error_message, group_id: group }
           expect(response).to render_template(:index)
        end
      end 
 
      context "when user is logged out" do
        it "redirect to new_user_session_path" do
          post :create, params: { message: error_message, group_id: group.id }
          expect(response).to render_template(:index)
        end
      end
  end
end