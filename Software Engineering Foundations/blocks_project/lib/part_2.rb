require "byebug"

def all_words_capitalized?(words_arr)
  words_arr.all? { |word| word == word.capitalize }
end

def no_valid_url?(urls_arr)
  valid_urls = [".com", ".net", ".io", ".org"]

  urls_arr.none? do |url|
    valid_urls.any?{ |valid_url| url.end_with?(valid_url) }
  end
end

def any_passing_students?(arr_students_hash)
  arr_students_hash.any? { |student| average(student[:grades]) >= 75 }
end

def average(grades)
  grades.sum / (grades.length * 1.0)
end