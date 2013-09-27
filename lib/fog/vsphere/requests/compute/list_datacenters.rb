module Fog
  module Compute
    class Vsphere
      class Real

        def list_datacenters filters = {}
          raw_datacenters.map do |dc|
            {
              :id => managed_obj_id(dc),
              :name => dc.name,
              :path => raw_getpathmo(dc),
              :status => dc.overallStatus
            }
          end
        end

        protected

        def raw_getpathmo mo 
          if mo.parent == nil or mo.parent.name == @connection.rootFolder.name then
            [ mo.name ]
          else
            [ *raw_getpathmo(mo.parent), mo.name ] 
          end
        end

        def raw_datacenters
          @raw_datacenters ||= @connection.rootFolder.childEntity.grep(RbVmomi::VIM::Datacenter)
        end

        def find_datacenters name=nil
          name ? [find_raw_datacenter(name)] : raw_datacenters
        end
      end

      class Mock
        def list_datacenters filters = {}
          [ {:name => "Solutions", :status => "grey"}, {:name => "Solutions2", :status => "green" }]
        end
      end
    end
  end
end
