module EasyType
	module Utils

		def self.included(parent)
			parent.extend(Utils)
		end

		class InstancesResults < Hash
			def column_data(column_name)
				fetch(column_name) do 
					fail "Column #{column_name} not found in results. Results contain #{keys.join(',')}"
				end
			end
		end


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


		def comment?(line)
			line.start_with?('#') || line.start_with?("\n")
		end
	end
end

