module StaticHelper

  def gmaps_options(marker_data, detect_location = false)
    data = default_settings(marker_data)
    if !params[:location].blank? || !params[:query].blank?
      data[:map_options][:auto_adjust] = true
    end
    data
  end

  def default_settings(marker_data)
    {
      :markers => {:data => marker_data, :options => {"custom_infowindow_class" => "painting-info"}},
      :map_options => {
                       :center_latitude => 10, 
                       :center_longitude => 0, 
                       :zoom => 3, 
                       :auto_adjust => false
                      }
    }
  end

end
