module Puppet::Parser::Functions
  newfunction(:get_file_key_path_value, :type => :rvalue) do |arguments|
    raise(Puppet::ParseError, "prefix(): Wrong number of arguments " +
    "given (#{arguments.size} instead of 2)") if arguments.size != 2

    file_path = arguments[0]
    key_path = arguments[1]

    config = function_parsejson([function_file([file_path])])
    value = function_try_get_value([config, key_path, "not found"])
      
    if value == "not found"
#      raise Puppet::ParseError, __method__.to_s + "(): unable to find #{key_path} in #{file_path}"
      raise Puppet::ParseError, __method__.to_s + "(): #{config}"
    end

    return value

  end
end

