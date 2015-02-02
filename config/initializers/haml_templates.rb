require 'haml'

Rails.application.assets.register_mime_type 'text/html', '.html'
Rails.application.assets.register_engine '.haml', Tilt::HamlTemplate

class HamlTemplate < Tilt::HamlTemplate
  def prepare
    @options = @options.merge :format => :html5
    super
  end
end

config.before_initialize do |app|
  require 'sprockets'
  Sprockets::Engines #force autoloading
  Sprockets.register_engine '.haml', HamlTemplate
end