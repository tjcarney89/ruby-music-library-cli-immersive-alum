require 'pry'

class Song
  attr_accessor :name, :artist, :genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def artist=(artist)
    if artist != nil && !artist.songs.include?(self)
      artist.add_song(self)
    end
    @artist = artist
  end

  def genre=(genre)
    if genre != nil && !genre.songs.include?(self)
      genre.add_song(self)
    end
    @genre = genre
  end

  def self.new_from_filename(filename)
    components = filename.split(" - ")
    artist = Artist.find_or_create_by_name(components[0])
    song = Song.find_or_create_by_name(components[1])
    genre = Genre.find_or_create_by_name(components[2].chomp(".mp3"))
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    included = false
    @@all.each do |song|
      if song.name == self.name
        included = true
      end
    end
    if !included
      @@all << self
    end
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.test
    puts "Testing..."
    ans = gets
  end

end
