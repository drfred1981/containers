target "docker-metadata-action" {}

variable "APP" {
  default = "postgres-backup-s3"
}

variable "VERSION" {
  default = "1.0.0"
}

variable "SOURCE" {
  default = "https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
