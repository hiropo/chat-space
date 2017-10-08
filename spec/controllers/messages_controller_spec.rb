require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:groups) { user.groups }
  let(:messages) { create_list(:message, 5, user: user, group: group) }
  let(:valid_message) {{ message: attributes_for(:message), group_id: group }}
  let(:error_message) {{ message: {text: "", image: ""}, group_id: group}}

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
      subject{
       post :create,
       params: valid_message
      }
        it "message is inserted in the database" do
          expect do
          subject
          end.to change(Message, :count).by(1)
        end
        it "message is inserted and redirect to group_messages_path" do
          subject
          expect(response).to redirect_to group_messages_path
        end        


      context "when message is NOT inserted" do
        before do
          login_user user
        end
        subject{
          post :create,
          params: error_message
        }
        it "meesage is NOT inserted in the database" do
          expect do
          subject
          end.not_to change(Message, :count)
        end
       
        it "message is NOT inserted and renders the :index template" do
           subject
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