namespace :generate do
  require 'open-uri'
  
  desc 'load paintings by artist'

  task :all_artists do
    page = Nokogiri::HTML(open('http://www.the-athenaeum.org/people/list.php?sort=name_up&ltr=!'))

    stati
  end
end