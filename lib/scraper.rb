require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  attr_reader :url, :all

  def initialize
    @url = "http://learn-co-curriculum.github.io/"\
            "site-for-scraping/courses"
    @all = []
  end

  def get_page
    Nokogiri::HTML(open(url))
  end

  def get_courses
    self.get_page.css(".post")
    # @titles = get_page.css(".post h2")
    # @dates = get_page.css(".post em.date")
    # @descs = get_page.css(".post p")
    # counter = 0
    # @titles.length.times do
    #   new_hash = {}
    #   new_hash[:title] = @titles[counter].text
    #   new_hash[:date] = @dates[counter].text
    #   new_hash[:desc] = @descs[counter].text
    #   all << new_hash
    #   counter += 1
    # end
    # puts all
    # all
  end

  def make_courses
    self.get_courses.each do |post|
        course = Course.new
        course.title = post.css("h2").text
        course.schedule = post.css(".date").text
        course.description = post.css("p").text
      end
  end


  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end

# Scraper.new.print_courses
