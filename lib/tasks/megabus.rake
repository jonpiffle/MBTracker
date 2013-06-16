require 'rubygems'
require 'mechanize'
require 'open-uri'

task :get_date => :environment do

  agent = Mechanize.new
  originCode = 89
  destinationCode = 123

  start_date = Tracker.last ? Tracker.last.first_unavailable_at : Time.now + 75.days

  div = nil 
  while div.blank?
    month = start_date.month
    day = start_date.day
    year = start_date.year
    url = "http://us.megabus.com/JourneyResults.aspx?originCode=#{originCode}&destinationCode=#{destinationCode}&outboundDepartureDate=#{month}%2f#{day}%2f#{year}&inboundDepartureDate=&passengerCount=1&transportType=0&concessionCount=0&nusCount=0&outboundWheelchairSeated=0&outboundOtherDisabilityCount=0&inboundWheelchairSeated=0&inboundOtherDisabilityCount=0&outboundPcaCount=0&inboundPcaCount=0&promotionCode=&withReturn=0"

    page = agent.get(url)
    div = page.search('.paragraph_error')
    start_date+=1.day
  end 

  if start_date.to_date-1.day > (Tracker.last ? Tracker.last.first_unavailable_at.to_date : Time.now.to_date)
    t = Tracker.new(:first_unavailable_at => start_date-1.day)
    h = Hominid::API.new('7f28b65048208c6ddea75375a3034eb6-us7')
    #list = h.lists['data'].first
    campaign = h.campaigns['data'].first
    puts campaign['id']
    h.campaign_send_now(campaign['id'])
    t.save
  end
 end
