xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title '次の連休'
    xml.link 'http://misc.tokyoenvious.net/holidays/holidays.html'

    @entries.each do |entry|
      xml.item do
        xml.title entry['body']
        xml.link 'http://misc.tokyoenvious.net/holidays/holidays.html'
        xml.description entry['body']
        xml.pubDate Time.parse(entry['date']).rfc822() # requires TZ=JST
        xml.guid "http://misc.tokyoenvious.net/holidays/holidays.html##{entry['date']}"
      end
    end
  end
end
