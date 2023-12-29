resource "yandex_iam_service_account" "this" {
  name        = "${var.name}-ig-sa"
  description = "service account to manage VMs in instance group"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = var.folder_id

  role = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}
