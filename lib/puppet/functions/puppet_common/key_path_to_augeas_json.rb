# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----
## args : full file path, including filename
# ---- original file header ----
#
# @summary
#   Summarise what the function does here
#
Puppet::Functions.create_function(:'puppet_common::key_path_to_augeas_json') do
  # @param arguments
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :arguments
  end


  def default_impl(*arguments)
    
    raise(Puppet::ParseError, "prefix(): Wrong number of arguments " +
    "given (#{arguments.size} instead of 1)") if arguments.size != 1

    arg = arguments[0]
    
    unless arg.is_a?(String)
      raise Puppet::ParseError, "test_func(): expected first argument to be an String, got #{arg.inspect}"
    end
    
    augeas_array = arg.split("/").collect do |i|
      "dict/entry[. = '#{i}']"
    end

    result = augeas_array.join("/")
    
    return test
  
  end
end
