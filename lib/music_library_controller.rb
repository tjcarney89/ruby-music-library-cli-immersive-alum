require_relative "../config/environment.rb"
require "pry"
class MusicLibraryController

  attr_accessor :path

  def initialize(path="./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
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
    answer = gets.chomp
    if answer != "exit"
      case answer
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      else
        call
      end
    end


  end

  def list_songs
    songs = Song.all.sort { |a, b| a.name <=> b.name }
    songs.each_with_index do |song, index|
      name = song.name
      artist = song.artist.name
      genre = song. genre.name
      puts  "#{index+1}. #{artist} - #{name} - #{genre}"
    end
  end

  def list_artists
    artists = Artist.all.sort { |a, b| a.name <=> b.name }
    artists.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    genres = Genre.all.sort { |a, b| a.name <=> b.name }
    genres.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets
    artist = Artist.find_by_name(name)
    if artist != nil
      songs = artist.songs.sort { |a, b| a.name <=> b.name }
      songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets
    genre = Genre.find_by_name(name)
    if genre != nil
      songs = genre.songs.sort { |a, b| a.name <=> b.name }
      songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    #list_songs
    answer = gets.strip.to_i
    songs = Song.all.sort { |a, b| a.name <=> b.name }
    if answer > 0 && answer <= songs.size - 1
      selected_song = songs[answer-1]
      puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
    end
  end
end
