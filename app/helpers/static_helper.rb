module StaticHelper

  def gmaps_options(marker_data, detect_location = false)
    data = default_settings(marker_data)
    if !params[:query].empty?
      data[:map_options][:auto_adjust] = true
    elsif detect_location
      set_for_user_location(data)
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

  def set_for_user_location(data)
    data[:map_options][:center_longitude] = nil
    data[:map_options][:center_latitude] = nil
    data[:map_options][:detect_location] = true
    data[:map_options][:center_on_user] = true
    data[:map_options][:zoom] = 7
  end


end
