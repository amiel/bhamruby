module EventsHelper
  def link_to_map title, address
    link_to h(title), "http://maps.google.com/maps?q=#{url_encode @next_event.location_address.gsub(/\s/,' ')}"
  end
end
