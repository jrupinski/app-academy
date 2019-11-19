require "byebug"

def all_words_capitalized?(word_array)
    word_array.all? { |word| word.capitalize == word }
end

def no_valid_url?(links)
    valid_endings = [".com", ".net", ".io",".org"]
    
    links.none? do |link|
        # debugger
        valid_endings.any? { |ending| link.end_with?(ending) }
    end
end

def any_passing_students?(students)
    students.any? do |student|
        student[:grades].sum / student[:grades].count * 1.0  > 75
    end
end