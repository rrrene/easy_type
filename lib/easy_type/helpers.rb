module EasyType
	#
	# Contains a set of helpe methods and classed tha can be used throughtout EasyType
	module Helpers
		# @private
		def self.included(parent)
			parent.extend(Helpers)
		end

		class InstancesResults < Hash
			#
			# @param [Symbol] column_name the name of the column to extract from the Hash
			# @raise [Puppet::Error] when the column name is not used in the Hash
			# @return content of the specified key in the Hash
			#
			def column_data(column_name)
				fetch(column_name) do 
					fail "Column #{column_name} not found in results. Results contain #{keys.join(',')}"
				end
			end
		end


		#
		# Convert a comma separated string into an Array of Hashes
		#
		# @param [String] csv_data comma separated string
		# @param [Array] headers of [Symbols] specifying the key's of the Hash
		# @return [Array] of [InstancesResults] a special Hash 
		#
		def convert_csv_data_to_hash(csv_data, headers = [])
			data = []

			csv_data.split("\n").each do | row |
				columnized = row.split(',')
				columnized.map!{|column| column.strip}
				if headers.empty?
					headers = columnized
				elsif row.include?('----')
					#do nothing
				else
					values = headers.zip(columnized)
					data << InstancesResults[values]
				end
			end
			data
		end
	end
end

