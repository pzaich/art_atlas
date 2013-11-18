module MuseumsHelper
  def museum_page_title(params)
    title = "Art"
    title << " by #{params[:query]}" if !params[:query].blank?
    title << " near #{params[:location]}" if !params[:location].blank?
  end
end
