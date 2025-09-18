locals {
  device_evpn_interfaces = flatten([
    for device in local.devices : [
      {
        device_name                                             = device.name
        key                                                     = "${device.name}-evpn_interface"
        interface_name                                          = try(local.device_config[device.name].evpn_interface.interface_name, local.defaults.iosxr.configuration.evpn_interface.interface_name, null)
        core_isolation_group                                    = try(local.device_config[device.name].evpn_interface.core_isolation_group, local.defaults.iosxr.configuration.evpn_interface.core_isolation_group, null)
        delete_mode                                             = try(local.device_config[device.name].evpn_interface.delete_mode, local.defaults.iosxr.configuration.evpn_interface.delete_mode, null)
        ethernet_segment_identifier_type_zero_bytes_1           = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_bytes_1, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_bytes_1, null)
        ethernet_segment_identifier_type_zero_bytes_23          = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_bytes_23, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_bytes_23, null)
        ethernet_segment_identifier_type_zero_bytes_45          = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_bytes_45, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_bytes_45, null)
        ethernet_segment_identifier_type_zero_bytes_67          = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_bytes_67, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_bytes_67, null)
        ethernet_segment_identifier_type_zero_bytes_89          = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_bytes_89, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_bytes_89, null)
        ethernet_segment_identifier_type_zero_esi               = try(local.device_config[device.name].evpn_interface.ethernet_segment_identifier_type_zero_esi, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_identifier_type_zero_esi, null)
        ethernet_segment_load_balancing_mode_all_active         = try(local.device_config[device.name].evpn_interface.ethernet_segment_load_balancing_mode_all_active, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_load_balancing_mode_all_active, null)
        ethernet_segment_load_balancing_mode_port_active        = try(local.device_config[device.name].evpn_interface.ethernet_segment_load_balancing_mode_port_active, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_load_balancing_mode_port_active, null)
        ethernet_segment_load_balancing_mode_single_active      = try(local.device_config[device.name].evpn_interface.ethernet_segment_load_balancing_mode_single_active, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_load_balancing_mode_single_active, null)
        ethernet_segment_load_balancing_mode_single_flow_active = try(local.device_config[device.name].evpn_interface.ethernet_segment_load_balancing_mode_single_flow_active, local.defaults.iosxr.configuration.evpn_interface.ethernet_segment_load_balancing_mode_single_flow_active, null)
      }
    ]
    if try(local.device_config[device.name].evpn_interface, null) != null || try(local.defaults.iosxr.configuration.evpn_interface, null) != null
  ])
}

resource "iosxr_evpn_interface" "evpn_interface" {
  for_each = { for evpn_interface in local.device_evpn_interfaces : evpn_interface.key => evpn_interface }

  device                                                  = each.value.device_name
  interface_name                                          = each.value.interface_name
  core_isolation_group                                    = each.value.core_isolation_group
  delete_mode                                             = each.value.delete_mode
  ethernet_segment_identifier_type_zero_bytes_1           = each.value.ethernet_segment_identifier_type_zero_bytes_1
  ethernet_segment_identifier_type_zero_bytes_23          = each.value.ethernet_segment_identifier_type_zero_bytes_23
  ethernet_segment_identifier_type_zero_bytes_45          = each.value.ethernet_segment_identifier_type_zero_bytes_45
  ethernet_segment_identifier_type_zero_bytes_67          = each.value.ethernet_segment_identifier_type_zero_bytes_67
  ethernet_segment_identifier_type_zero_bytes_89          = each.value.ethernet_segment_identifier_type_zero_bytes_89
  ethernet_segment_identifier_type_zero_esi               = each.value.ethernet_segment_identifier_type_zero_esi
  ethernet_segment_load_balancing_mode_all_active         = each.value.ethernet_segment_load_balancing_mode_all_active
  ethernet_segment_load_balancing_mode_port_active        = each.value.ethernet_segment_load_balancing_mode_port_active
  ethernet_segment_load_balancing_mode_single_active      = each.value.ethernet_segment_load_balancing_mode_single_active
  ethernet_segment_load_balancing_mode_single_flow_active = each.value.ethernet_segment_load_balancing_mode_single_flow_active
}
