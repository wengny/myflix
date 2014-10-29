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

  describe "DELETE destroy" do
    context "with authenticated users" do 
      let(:alice) {Fabricate(:user)}
      before {session[:user_id] = alice.id}

      it "redirects to the my queue page" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
      it "deletes the queue item" do
        queue_item = Fabricate(:queue_item, user:alice)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "normalizes the remaining queue items" do
        queue_item1 = Fabricate(:queue_item, user:alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user:alice, position: 2)
        delete :destroy, id: queue_item1.id
        expect(QueueItem.first.position).to eq(1)
      end

      it "does not delete the queue item if the queue item is not in the current user's queue" do
        bob = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user:bob)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirects to the sign in page for unauthenticated users" do
        delete :destroy, id: 3
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      let(:alice) {Fabricate(:user)}
      let(:video) {Fabricate(:video)}
      let(:queue_item1) { Fabricate(:queue_item, user:alice, position: 1, video: video)}
      let(:queue_item2) { Fabricate(:queue_item, user:alice, position: 2, video: video)}

      before do
        session[:user_id] = alice.id
      end

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id:queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id:queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id:queue_item2.id, position: 2}]
        #prefer to use alice which will get items from database, so do not need to call reload.
        expect(alice.queue_items.map(&:position)).to eq([1, 2])
        # require 'pry'; binding.pry
        # expect(queue_item1.reload.position).to eq(2)
        # expect(queue_item2.reload.position).to eq(1)
      end
    end

    context "with invalid inputs" do
      let(:alice) {Fabricate(:user)}
      let(:video) {Fabricate(:video)}
      let(:queue_item1) { Fabricate(:queue_item, user:alice, position: 1, video: video)}
      let(:queue_item2) { Fabricate(:queue_item, user:alice, position: 2, video: video)}

      before do
        session[:user_id] = alice.id
      end

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.1}, {id:queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.1}, {id:queue_item2.id, position: 1}]
        expect(flash[:error]).to be_present
      end
      it "does not change the queue item" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.1}, {id:queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
        expect(queue_item2.reload.position).to eq(2)
      end
    end
    
    context "with unauthenticated users" do
      it "redirects to the sign in page for unauthenticated users" do
        post :update_queue, queue_items: [{id: 1, position: 2}, {id: 2, position: 3}]
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        video = Fabricate(:video)
        bob = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user:bob, position: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user:alice, position: 2, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id:queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)

      end
    end
  end

end

