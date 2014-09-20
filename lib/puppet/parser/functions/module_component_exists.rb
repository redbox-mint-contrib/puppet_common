## args : full file path, including filename
require 'fileutils'
module Puppet::Parser::Functions
   newfunction(:module_component_exists) do |args|
     Puppet::Parser::Functions.function('get_module_path')
     unless args.length == 2
       puts "Usage: module_component_exists.rb <module_name> <component relative path>\n"
       exit
     end
     module_path = function_get_module_path( [ args[0]] )
     path_to_check = File.join(module_path, args[1])
     return File.exists?(path_to_check)
   end
end
