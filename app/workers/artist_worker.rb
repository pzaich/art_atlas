class ArtistWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(link)
    ArtistGenerator.new(link).create_artist
  end

end