require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


    def self.scrape_index_page(index_url)
      html = File.read("./fixtures/student-site/index.html")
      doc = Nokogiri::HTML(html)
      students = []
      doc.css("div.student-card").each do |stu_card|
      student_cards = {}
      student_cards[:name] = stu_card.css("h4.student-name").text
      student_cards[:location] = stu_card.css("p.student-location").text
      student_cards[:profile_url] = stu_card.css("a").attribute("href").value
      students << student_cards
      end
      students
    end



  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile = {}
    doc.css("div.social-icon-container").map do |link|
    profile[:twitter] = link["href"][0]#doc.css.("a").first.css.attribute("href").value
    #profile[:linkedin] = doc.css.("a").first.css.attribute("href").value
    #profile[:github] = doc.css.("a").first.css.attribute("href").value
    #profile[:blog] = doc.css.("a").first.css.attribute("href").value
    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css("div.description-holder p").text
    profile
    binding.pry
  end
end

end
