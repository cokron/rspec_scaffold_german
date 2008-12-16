module FormHelper
  def error_handling_form_for(record_or_name_or_array, *args, &proc)
    options = args.detect { |argument| argument.is_a?(Hash) }
    if options.nil?
      options = {:builder => ErrorHandlingFormBuilder}
      args << options
    end
    options[:builder] = ErrorHandlingFormBuilder unless options.nil?
    concat("<fieldset><legend>#{options[:title]}</legend>")
    form_for(record_or_name_or_array, *args, &proc)
    concat("</fieldset>")
  end
end
