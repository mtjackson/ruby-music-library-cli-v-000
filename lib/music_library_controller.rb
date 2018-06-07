class MusicLibraryController
  attr_accessor :path, :new_music_importer

  def initialize(path='./db/mp3s')
    @path = path
    @new_music_importer = MusicImporter.new(@path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    while input = gets.strip
      if input == "exit"
        break
      end
    end

  end

  def list_songs
    i = 1
    song_list = []

    self.new_music_importer.each do |song|
      song_list << song
    end

    sorted_list = song_list.sort_by{|song| song.name}

    sorted_list.each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i+= 1
    end
  end

  def list_artists
    i = 1
    artist_list = Artist.all.sort_by{|artist| artist.name}
    artist_list.each do |artist|
      puts "#{i}. #{artist.name}"
      i+= 1
    end
  end

  def list_genres
    i = 1
    genre_list = Genre.all.sort_by{|genre| genre.name}
    genre_list.each do |genre|
      puts "#{i}. #{genre.name}"
      i+= 1
    end
  end

  def list_songs_by_artist
    artist_song_list = []
    puts "Please enter the name of an artist:"
    input = gets.strip
    Artist.all.select do |artist|
      if artist.name == input
        artist.songs.each do |song|
          artist_song_list << song
        end
      end
    end

    artist_song_list = artist_song_list.sort_by{|song| song.name}
    i = 1
    artist_song_list.each do |song|
      puts "#{i}. #{song.name} - #{song.genre.name}"
      i+= 1
    end
  end
end
