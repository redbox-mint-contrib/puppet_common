## args : full file path, including filename
module Puppet::Parser::Functions
   newfunction(:basename, :type => :rvalue) do |args|
     File.basename(args[0])
   end
end

