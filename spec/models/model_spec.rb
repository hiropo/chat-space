require 'rails_helper'

describe Message do
  describe '#create' do
    context 'enbale to save messages' do
      it "is valid with a message" do
        message = build(:message, image: '')
        expect(message).to be_valid
      end

      it "is valid with a image" do
        message = build(:message, body: '')
        expect(message).to be_valid
      end

      it "is valid with a image and message" do
        message = build(:message)
        expect(message).to be_valid
      end
    end

    context 'unable to save messages'do
      it "is invalid without a image and message" do
        message = build(:message, body: '', image: '')
        message.valid?
        expect(message).not_to be_valid
      end

      it "is invalid without a group_id" do
        message = build(:message, group_id: '')
        message.valid?
        expect(message).not_to be_valid
      end 

      it "is invalid without a user_id" do
        message = build(:message, user_id: '')
        message.valid?
        expect(message).not_to be_valid
      end  
    end
    
  end
end
