# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Creating users..."
users = User.create([
  { username: 'creator_singermir' },
  { username: 'creator_oldeuboi' },
  { username: 'creator_inception' },
  { username: 'user_oceanpeas' },
  { username: 'user_creambee' },
  { username: 'user_sunsetblvd' },
  { username: 'user_waterfall' },
  { username: 'user_glovepuppy' }
])
puts "Users created"

puts "Creating polls..."
polls = Poll.create([
  { user_id: User.find_by_username('creator_singermir').id, title: 'Best programming languages' },
  { user_id: User.find_by_username('creator_inception').id, title: 'Vacation plans' },
  { user_id: User.find_by_username('creator_oldeuboi').id, title: 'Dinner wars' }
])
puts "Polls created!"

puts "Creating Questions..."
questions = Question.create([
  { poll_id: Poll.find_by_title('Best programming languages').id, text: 'Is ruby a good language?' },
  { poll_id: Poll.find_by_title('Best programming languages').id, text: 'Assembly in webdev - yay, or nay?' },
  { poll_id: Poll.find_by_title('Vacation plans').id, text: 'Best vacation spot?' },
  { poll_id: Poll.find_by_title('Dinner wars').id, text: 'Pizza or Lasagne?' }
])
puts "Questions created!"

puts "Creating answerChoices..."
answer_choices = AnswerChoice.create([
  { question_id: Question.find_by_text('Is ruby a good language?').id, text: 'Yes, it is a good language' },
  { question_id: Question.find_by_text('Is ruby a good language?').id, text: 'No, I preffer other languages' },
  { question_id: Question.find_by_text('Assembly in webdev - yay, or nay?').id, text: 'Yee-haw' },
  { question_id: Question.find_by_text('Assembly in webdev - yay, or nay?').id, text: 'Nope' },
  { question_id: Question.find_by_text('Best vacation spot?').id, text: 'Italy' },
  { question_id: Question.find_by_text('Best vacation spot?').id, text: 'Poland' },
  { question_id: Question.find_by_text('Best vacation spot?').id, text: 'Spain' },
  { question_id: Question.find_by_text('Best vacation spot?').id, text: 'France' },
  { question_id: Question.find_by_text('Pizza or Lasagne?').id, text: 'Pizza' },
  { question_id: Question.find_by_text('Pizza or Lasagne?').id, text: 'Lasagne' }
])
puts "AnswerChoices created!"

puts "Creating responses..."
responses = Response.create([
  { user_id: User.find_by_username('creator_singermir').id, answer_choice_id: AnswerChoice.find_by_text('Yes, it is a good language').id },
  { user_id: User.find_by_username('creator_singermir').id, answer_choice_id: AnswerChoice.find_by_text('Nope').id },
  { user_id: User.find_by_username('creator_singermir').id, answer_choice_id: AnswerChoice.find_by_text('Italy').id },
  { user_id: User.find_by_username('creator_singermir').id, answer_choice_id: AnswerChoice.find_by_text('Pizza').id },
  
  { user_id: User.find_by_username('user_oceanpeas').id, answer_choice_id: AnswerChoice.find_by_text('No, I preffer other languages').id },
  { user_id: User.find_by_username('user_oceanpeas').id, answer_choice_id: AnswerChoice.find_by_text('Yee-haw').id },
  { user_id: User.find_by_username('user_oceanpeas').id, answer_choice_id: AnswerChoice.find_by_text('Italy').id },
  { user_id: User.find_by_username('user_oceanpeas').id, answer_choice_id: AnswerChoice.find_by_text('Lasagne').id },

  { user_id: User.find_by_username('user_creambee').id, answer_choice_id: AnswerChoice.find_by_text('No, I preffer other languages').id },
  { user_id: User.find_by_username('user_creambee').id, answer_choice_id: AnswerChoice.find_by_text('Yee-haw').id },
  { user_id: User.find_by_username('user_creambee').id, answer_choice_id: AnswerChoice.find_by_text('France').id },
  { user_id: User.find_by_username('user_creambee').id, answer_choice_id: AnswerChoice.find_by_text('Pizza').id },

  { user_id: User.find_by_username('user_sunsetblvd').id, answer_choice_id: AnswerChoice.find_by_text('No, I preffer other languages').id },
  { user_id: User.find_by_username('user_sunsetblvd').id, answer_choice_id: AnswerChoice.find_by_text('Nope').id },
  { user_id: User.find_by_username('user_sunsetblvd').id, answer_choice_id: AnswerChoice.find_by_text('Spain').id },
  { user_id: User.find_by_username('user_sunsetblvd').id, answer_choice_id: AnswerChoice.find_by_text('Pizza').id },
  
  { user_id: User.find_by_username('user_waterfall').id, answer_choice_id: AnswerChoice.find_by_text('Yes, it is a good language').id },
  { user_id: User.find_by_username('user_waterfall').id, answer_choice_id: AnswerChoice.find_by_text('Pizza').id },
  { user_id: User.find_by_username('user_waterfall').id, answer_choice_id: AnswerChoice.find_by_text('Nope').id },
  { user_id: User.find_by_username('user_waterfall').id, answer_choice_id: AnswerChoice.find_by_text('France').id },
  { user_id: User.find_by_username('user_waterfall').id, answer_choice_id: AnswerChoice.find_by_text('Lasagne').id },

  { user_id: User.find_by_username('user_glovepuppy').id, answer_choice_id: AnswerChoice.find_by_text('Yes, it is a good language').id },
  { user_id: User.find_by_username('user_glovepuppy').id, answer_choice_id: AnswerChoice.find_by_text('Nope').id },
  { user_id: User.find_by_username('user_glovepuppy').id, answer_choice_id: AnswerChoice.find_by_text('France').id },
  { user_id: User.find_by_username('user_glovepuppy').id, answer_choice_id: AnswerChoice.find_by_text('Lasagne').id }
])
puts "Responses created!"