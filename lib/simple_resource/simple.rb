require 'utils/simple_resource'

Puppet::Type.type(:simple_resource).provide(:simple) do
  include ::Utils::SimpleResource

  desc "A default simple resource provider"

  mk_resource_methods

end