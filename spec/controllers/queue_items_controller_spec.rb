require 'spec_helper'

describe QueueItemsController do 
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to the sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      let(:alice) {Fabricate(:user)}
      let(:monk) {Fabricate(:video)}
      before {session[:user_id] = alice.id}

      it "redirects to the my queue page" do
        post :create, video_id: monk.id
        expect(response).to redirect_to my_queue_path
      end

      it "creates a queue item" do
        post :create, video_id: monk.id
        expect(QueueItem.count).to eq(1)
      end

      it "creates the queue item that is associated with the video" do
        post :create, video_id: monk.id
        expect(QueueItem.first.video).to eq(monk)
      end

      it "creates the queue item that is associated with the sign in user" do
        post :create, video_id: monk.id
        expect(QueueItem.first.user).to eq(alice)
      end

      it "puts the video as the last one in the queue" do
        Fabricate(:queue_item, video: monk, user: alice)
        video2 =Fabricate(:video)
        post :create, video_id: video2.id
        video2_queue_item = QueueItem.where(video_id: video2.id, user_id: alice.id).first
        expect(video2_queue_item.position).to eq(2)
      end

      it "doesn not add the video in the queue if the video is already in the queue" do
        Fabricate(:queue_item, video: monk, user: alice)
        post :create, video_id: monk.id
        expect(QueueItem.count).to eq(1)
      end
    end
    
    context "with unauthenticated users" do
      it "redirects to the sign in page for unauthenticated users" do
        post :create, video_id: 3
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end

