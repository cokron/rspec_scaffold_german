class <%= class_name %> < ActiveRecord::Base

  def display_name
    return name #TODO: replace this by an attribute of
  end

<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>

<% if attributes.any?{ |a| a.name == 'permalink'}   %>
  def before_create
    set_key
  end

  def to_param
    permalink.blank? ? id.to_s : permalink
  end

  def self.find(*args)
    begin
    <%= singular_name %> = super(*args)
    rescue ActiveRecord::RecordNotFound
    <%= singular_name %> = self.find_by_permalink(*args)
    raise ActiveRecord::RecordNotFound unless <%= singular_name %>
    end
    <%= singular_name %>
  end
  private
  def set_key
    self.permalink ||= make_key(name)
  end

  def make_key2(name)
    require 'unicode'
      "#{id}"+Unicode::normalize_KD("-"+name+"-").downcase.gsub(/[^a-z0-9\s_-]+/,'').gsub(/[\s_-]+/,'-')[0..-2]
  end

  def make_key(name)
    key = name.downcase
    key = key.gsub(/ä/, 'ae').gsub(/ö/, 'oe').gsub(/ü/, 'ue').gsub(/ß/, 'ss').gsub(/[^a-zA-Z0-9]+/, '_').gsub(/_$/, '')
    new_key = key
    i = 0
    while <%= class_name %>.find_by_permalink(new_key)
      i += 1
      new_key = "#{key}#{i}"
    end
    new_key
  end
<% end %>
end
