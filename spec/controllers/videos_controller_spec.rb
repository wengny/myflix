require 'spec_helper'

describe VideosController do 
  describe "GET show" do
    it "sets @video for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
    
    it "redirects the user to the sign in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET search" do
    it "sets @search_result for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      mimi = Fabricate(:video, title: "mimi")
      get :search, search_term: "mi"
      expect(assigns(:search_result)).to eq([mimi])
    end

    it "redirects the sign in page for the unauthenticated users" do
      mimi = Fabricate(:video, title: "mimi")
      get :search, search_term: "mi"
      expect(response).to redirect_to sign_in_path
    end
  end
  
end