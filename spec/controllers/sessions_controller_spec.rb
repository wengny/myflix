require 'spec_helper'

describe SessionsController do 
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      let(:helen) { Fabricate(:user) }
  
      before do
        post :create, email: helen.email, password: helen.password
      end

      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(helen.id)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before do
        helen = Fabricate(:user) 
        post :create, email: helen.email, password: helen.password + 'abc'
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id 
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets the notice" do 
      expect(flash[:notice]).not_to be_blank
    end
  end
end