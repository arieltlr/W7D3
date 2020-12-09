require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
    describe 'Get#index' do
        it 'renders the users index' do 
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe 'Get#new' do 
        it 'brings up form to make a post' do
        allow(subject).to receive(:logged_in?).and_return(true)
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'Get #show' do 
        it 'renders the users :id page' do
            create(:user)
            get :show, params: {id: User.last.id}
            expect(response).to render_template(:show)
        end
    end

    describe 'POST #create' do 
        before :each do 
            create(:user)
            allow(subject).to receive(:current_user).and_return(User.last)
        end

       let(:valid_params) { {user: {username:  'Tom', password: 'anewpassword' }} }
        context 'with valid params' do 
            it 'creates the user' do 
                user :create, params: valid_params
                expect(User.last.username).to eq('Tom')
                expect(User.last.is_password?(password)).to eq('anewpassword')
            end
        end
    end
end   
