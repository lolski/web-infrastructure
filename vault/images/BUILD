load("@graknlabs_bazel_distribution//packer:rules.bzl", "deploy_packer")
load("@graknlabs_bazel_distribution//gcp:rules.bzl", "assemble_gcp")

assemble_gcp(
    name = "assemble-gcp-vault",
    install = "//vault/images:install-vault.sh",
    project_id = "vaticle-web-prod",
    disable_default_service_account = True,
    image_name = "vault-{{user `version`}}",
    source_image_family = "ubuntu-2004-lts",
    image_family = "web",
    zone = "europe-west2-b"
)

deploy_packer(
    name = "deploy-gcp-vault",
    target = ":assemble-gcp-vault",
)
