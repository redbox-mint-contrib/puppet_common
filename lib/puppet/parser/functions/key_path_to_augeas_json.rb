## args : full file path, including filename
module Puppet::Parser::Functions
  newfunction(:key_path_to_augeas_json, :type => :rvalue) do |arguments|
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

