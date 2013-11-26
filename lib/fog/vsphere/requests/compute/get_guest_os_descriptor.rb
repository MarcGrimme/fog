
module Fog
  module Compute
    class Vsphere
      class Real
        def list_disk_controller_types(datacenter_name, servertype_name, filters={})
          get_raw_server_type(servertype_name, datacenter_name)[:supportedDiskControllerList].select do | ctrl |
            filters[:id] != ctrl
          end.compact
        end 
      end
    end
  end
end
