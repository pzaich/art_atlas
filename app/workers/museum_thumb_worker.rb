class MuseumThumbWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(museum_id)
    museum = Museum.unscoped.find(museum_id)
    MuseumThumbGenerator.new(museum)
  end
end