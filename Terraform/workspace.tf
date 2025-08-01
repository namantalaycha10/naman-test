terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    token = "J9ObsldOLFYdOg.atlasv1.simtbFQhuayoBf6kwFCGEBQ81ARzEjqcylCPTivDqZqdhHaItHL8BuciyCkkFEAy2Q0"
    organization = "naman-cdp-test"

    workspaces {
      name = "aws-resource-test"
    }
  }
}