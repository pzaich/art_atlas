class MuseumGenerator
  attr_reader :museum
  def initialize(museum_url)
    f = open(museum_url)
    @page = Nokogiri::HTML(f)
    load_museum
    create_paintings if @museum.persisted?
    f.close
  end

  def load_museum
    @museum = Museum.where(name: set_name).first_or_create(address: set_address)
  end

  def set_address
    @page.search('br').each do |n|
      n.replace("\n")
    end
    raw_address = @page.css('#map_canvas').first.parent.parent.next_sibling.child.text
    raw_address.split("\n")[1..-1].join.strip if !raw_address.blank?
  end

  def set_name
    @page.css('#title').text.strip
  end

  def painting_page
    paintings_link = @page.css('#linkbar a')[2]['href']
    f = open("http://www.the-athenaeum.org#{paintings_link}")
    @painting_page = Nokogiri::HTML(f)
    f.close
  end

  def create_paintings(extra_list_page = nil)
    painting_page unless @painting_page
    if extra_list_page.nil? && @painting_page.css('.subtitle').last.css('a').any?
      @painting_page.css('.subtitle').last.css('a').each do |link|
        extra_list_page = Nokogiri::HTML(open("http://www.the-athenaeum.org#{link['href']}"))
        create_paintings(extra_list_page)
        puts 'load next page'
      end
    end
    page = extra_list_page || @painting_page
    page.search('br').each do |n|
      n.replace("\n")
    end
    (page.css('.r1') + page.css('.r2')).each do |row|
      painting_link = row.css('.list_title a').first['href']
      puts painting_link
      #PaintingGenerator.new("http://www.the-athenaeum.org/art/#{painting_link}", @museum)
      PaintingWorker.perform_async painting_link, @museum.id
    end
  end
end