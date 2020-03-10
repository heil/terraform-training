#cloud-config
mounts:
  - [ ${mount_device != "" ? mount_device : device}, "${mount_point}" ]

fs_setup:
  -   device: ${mount_device != "" ? mount_device : device}
      partition: none
      label: ${label}
      filesystem: ${filesystem}
