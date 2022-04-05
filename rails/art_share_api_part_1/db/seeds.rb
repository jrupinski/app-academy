# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create!(username: 'tester')
user_2 = User.create!(username: 'tester 2')
user_3 = User.create!(username: 'tester 3')

artwork_1 = Artwork.create!(
  title: "ass",
  image_url: "www.reddit.com",
  artist_id: user_1.id,
)

artwork_2 = Artwork.create!(
  title: "pepe",
  image_url: "www.wykop.pl",
  artist_id: user_2.id,
)

_artwork_share_1 = ArtworkShare.create!(
  artwork_id: artwork_1.id,
  viewer_id: user_2.id
)

_artwork_share_2 = ArtworkShare.create!(
  artwork_id: artwork_2.id,
  viewer_id: user_3.id
)
