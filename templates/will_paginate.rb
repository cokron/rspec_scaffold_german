require 'will_paginate'

# pagination
module WillPaginate
  module ViewHelpers
    @@pagination_options = {
      :class => 'pagination',
      :prev_label   => '&laquo; Vorherige Seite',
      :next_label   => 'Nächste Seite &raquo;',
          :inner_window => 4, # links around the current page
          :outer_window => 1, # links around beginning and end
          :separator    => ' ', # single space is friendly to spiders and non-graphic browsers
      :param_name   => :page,
      :params       => nil,
      :renderer     => 'WillPaginate::LinkRenderer',
      :page_links   => true,
      :container    => true

    }
    mattr_reader :pagination_options

  end
end


