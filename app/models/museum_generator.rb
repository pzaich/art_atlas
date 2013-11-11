class MuseumGenerator
  def initialize(museum_url)

    f = open(museum_url)
    @page = Nokogiri::HTML(f)
    load_museum
    f.close
  end

  def load_museum
    @museum = Museum.create(
      name: set_name,
      address: set_address
    )
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

end