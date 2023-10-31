resource "kubernetes_storage_class" "storage_class" {
  #depends_on = [helm_release.ebs_csi_driver]
  metadata {
    name = var.storage_class_name
  }
  storage_provisioner    = "kubernetes.io/aws-ebs"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"

}
