workspace(name = "graknlabs_web_infrastructure")

################################
# Load @graknlabs_dependencies #
################################

load("//dependencies/graknlabs:repositories.bzl", "graknlabs_dependencies")
graknlabs_dependencies()

# Load //builder/java
load("@graknlabs_dependencies//builder/java:deps.bzl", java_deps = "deps")
java_deps()

#####################################################################
# Load @graknlabs_bazel_distribution from (@graknlabs_dependencies) #
#####################################################################

load("@graknlabs_dependencies//distribution:deps.bzl", "graknlabs_bazel_distribution")
graknlabs_bazel_distribution()

load("@graknlabs_bazel_distribution//packer:deps.bzl", deploy_packer_dependencies="deps")
deploy_packer_dependencies()

load("@graknlabs_bazel_distribution//common:deps.bzl", "rules_pkg")
rules_pkg()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

######################################
# Load @graknlabs_web_infrastructure #
######################################

load("//dependencies/maven:artifacts.bzl", graknlabs_web_infrastructure_artifacts = "artifacts")

# Load rules_scala()
load("//dependencies/play:dependencies.bzl", "rules_scala_dependencies")
rules_scala_dependencies()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

# Load rules_play_routes()
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/graknlabs/skydoc.git",
    branch = "experimental-skydoc-allow-dep-on-bazel-tools",
)

load("//dependencies/play:dependencies.bzl", "rules_play_routes_dependencies")
rules_play_routes_dependencies()

load("@io_bazel_rules_play_routes//:workspace.bzl", "play_routes_repositories")
play_routes_repositories("2.7")

load("@play_routes//:defs.bzl", play_routes_pinned_maven_install = "pinned_maven_install")
play_routes_pinned_maven_install()

bind(
  name = "default-play-routes-compiler-cli",
  actual = "@io_bazel_rules_play_routes//default-compiler-clis:scala_2_12_play_2_7"
)

###############
# Load @maven #
###############
load("@graknlabs_dependencies//library/maven:rules.bzl", "maven")
maven(
    graknlabs_web_infrastructure_artifacts
)
