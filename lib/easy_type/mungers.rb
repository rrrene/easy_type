module EasyType
	module Mungers
		module Integer

		  ##
		  #
		  #
			def unsafe_munge(value)
				Integer(value)
      end

		end

		module Size

			def unsafe_munge(size)
        case size
        when /^\d+(K|k)$/ then size.chop.to_i * 1024
        when /^\d+(M|m)$/ then size.chop.to_i * 1024 * 1024
        when /^\d+(G|g)$/ then size.chop.to_i * 1024 * 1024 * 1024
        when /^\d+$/ then size.to_i
        else
          fail("invalid size")
        end
      end
    end

    module Upcase
      def unsafe_munge(string)
        string.upcase
      end
    end

    module Downcase
      def unsafe_munge(string)
        string.downcase
      end
    end

	end
end
