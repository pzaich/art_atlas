class PaintingWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(painting_link, museum_id)
    museum = Museum.find(museum_id)
    PaintingGenerator("http://www.the-athenaeum.org#{painting_link}", museum)
  end
end