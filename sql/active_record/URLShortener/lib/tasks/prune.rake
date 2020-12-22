namespace :prune do
  desc "Prune old entries from shortened_urls and visits tables"
  task old_urls!: :environment do
    puts "Pruning stale URLs and their associated visits..."
    minutes = ENV['minutes'].to_i || 60
    ShortenedUrl.prune(minutes)
  end
end