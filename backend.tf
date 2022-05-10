terraform {
  backend "local" {
    path = "/tf_statefiles/test_stack/terraform.tfstate"
  }
}

