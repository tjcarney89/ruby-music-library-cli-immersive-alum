require_relative "../config/environment.rb"

class Artist
  attr_accessor :name, :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    if song.artist == nil
      song.artist = self
    end
  end

  def genres
    genres = []
    @songs.each do |song|
      genres << song.genre unless genres.include?(song.genre)
    end
    genres
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    included = false
    @@all.each do |artist|
      if artist.name == self.name
        included = true
      end
    end
    if !included
      @@all << self
    end
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
end
