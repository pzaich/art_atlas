class MuseumThumbGenerator
  def initialize(museum)
    count = 0
    begin
      if !museum.avatar.exists?
        path = "#{Rails.root}/tmp/#{SecureRandom::hex}"

        File.open(path, 'wb') do |saved_file|

          open(Google::Search::Image.new(query: museum.name).first.uri, 'rb') do |image|
            saved_file.write(image.read)
          end
        end
        f = File.open(path)
        museum.update_attributes avatar: f
        puts "saved image for #{museum.name}"

        f.close
        f.delete
      end
    rescue
      count += 1
      retry if count < 3
    end
  end
end