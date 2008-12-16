require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= class_name %> do
  def valid_attributes
    {
<% attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= attribute.default_value %><%= attribute_index == attributes.length - 1 ? '' : ','%>
<% end -%>
    }
  end

  it "should create a new instance given valid attributes" do
    <%= class_name %>.create!(valid_attributes)
  end

  describe "required attributes" do
    def required_attributes
      {
<% attributes.each_with_index do |attribute, attribute_index| -%>
        #:<%= attribute.name %> => <%= attribute.default_value %><%= attribute_index == attributes.length - 1 ? '' : ','%>
<% end -%>
      }
    end

    before do
      @<%= singular_name %> = <%= class_name %>.new(required_attributes)
    end

    it "should validate with exactly the specified attributes" do
      @<%= singular_name %>.should validate_with_exactly(required_attributes)
    end
  end

end
