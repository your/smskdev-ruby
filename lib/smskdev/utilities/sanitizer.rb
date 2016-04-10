require 'smskdev/constants'

module Smskdev
  module Utilities
    module Sanitizer
      OPERATIONS
      .values
      .map { |param| [param[:mandatory], param[:optional]] }
      .flatten
      .each do |param|
        define_method("sanitize_#{param}") do |arg|
          case param
            when 'u'         then arg.strip
            when 'p'         then arg.strip
            when 'msg'       then URI.escape(arg.to_s)
            when 'to'        then arg.to_i
            when 'from'      then arg.to_i
            when 'type'      then 'text'
            when 'unicode'   then 1
            when 'queue'     then arg.strip
            when 'smslog_id' then arg.to_i
          end
        end
      end
    end
  end
end