namespace :URLShortener do
  desc "Purge stale entries from shortened_urls and visits tables"
  task destroy_stale_urls: :environment do
    puts "Destroying stale URLs and their associated visits..."
    ShortenedUrl.prune(1)
  end
end