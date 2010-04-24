module EventsHelper
  def link_to_map title, address
    link_to h(title), "http://maps.google.com/maps?q=#{url_encode address.gsub(/\s/,' ')}"
  end
end
