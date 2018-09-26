require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card").each do |student|
      #binding.pry
      student_hash = {name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value}
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    doc.css(".social-icon-container").css("a").each do |x|
      if (x.attribute("href").value).include?("twitter")
        student_hash[:twitter] = x.attribute("href").value
      elsif (x.attribute("href").value).include?("github")
          student_hash[:github] = x.attribute("href").value
      elsif (x.attribute("href").value).include?("facebook")
          student_hash[:facebook] = x.attribute("href").value
      elsif (x.attribute("href").value).include?("linkedin")
          student_hash[:linkedin] = x.attribute("href").value
      else
          student_hash[:blog] = x.attribute("href").value
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    student_hash
    #binding.pry

  end

end
