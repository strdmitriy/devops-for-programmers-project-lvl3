terraform {
  backend "remote" {
    organization = "hexlet"

    workspaces {
      name = "my-app"
    }
  }
}
