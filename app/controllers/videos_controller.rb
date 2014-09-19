class VideosController <ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def search
    @search_result = Video.search_by_title(params[:search_term])
  end
end