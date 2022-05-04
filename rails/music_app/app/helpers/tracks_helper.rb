module TracksHelper
  def ugly_lyrics(lyrics)
    note_sign = '&#9835;'
    formatted_lyrics = ''

    lyrics.each_line do |line|
      formatted_lyrics << "#{note_sign} #{h(line)}"
    end

    "<pre>#{formatted_lyrics}</pre>".html_safe
  end
end
