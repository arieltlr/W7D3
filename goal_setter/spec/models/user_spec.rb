require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}


  describe "uniqueness" do
    before (:each) do
      create(:user)
    end
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe "::find_by_credentials" do 
    let!(:user) { create(:user) }
    it "should find a user" do 
      expect(user.class.find_by_credentials(user.username, user.password)).to eq(user)
    end
  end

  describe "#is_password?" do 
    let!(:user) { create(:user) }
    context "with a valid password" do 
      it "should return true" do 
        expect(user.is_password?('onering')).to be true
      end 
    end

    context "with an invalid password" do 
      it "should return false" do 
        expect(user.is_password?('onesring')).to be false
      end 
    end 
  end

  describe "password=" do 
    let!(:user) { create(:user) }    
    it "should check if password exists" do
      expect(user.password).to_not be nil
    end

    it "sets password digest" do 
      expect(user.password_digest).to_not be nil
    end
  end

  describe "reset_session_token!" do 
    let!(:user) { create(:user) }    
    it "should set session token for user in DB" do 
      expect(user.session_token).to_not be nil 
    end 

    it "should return new session token" do  
      expect(user.session_token).to_not be(user.reset_session_token!)
    end
  end

end
