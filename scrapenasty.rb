require 'rubygems'
require 'mechanize'

phone_hash = {}


145.upto(145) do |page_number|

    agent = Mechanize.new
    agent.get("http://67.110.139.212:8088/job_ads/job_opening/list.php?z_page_size=200&z_page_no=#{page_number}")

    agent.page.encoding = "'UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''"
    #agent.page.encoding = "'UTF-8'"
    data = agent.page.parser.css("tr")
    data.each do |num|

     #phone_number
     phone_number = num.at_css('td[2]').text.scan(/\d{3}-*\d{3}-*\d{4}/).to_s.gsub(/-/,'')

     #phone_number = phone_number.gsub(/-/,'')

     #job_title
     job_title  = num.css('td[1]').text

     #hash 
     phone_hash[phone_number]= job_title
   end
end

  
phone_hash.each do |phone_num, job_title|
 puts  "#{phone_num} : #{job_title}"
end
