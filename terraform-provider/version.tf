terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.24.2"
    }
  }
}


provider "harness" {
  endpoint         = "https://qa.harness.io/gateway"
  account_id       = "OgiB4-xETamKNVAz-wQRjw"
  platform_api_key = "pat.OgiB4-xETamKNVAz-wQRjw.651d225d7b0600354d75c8a7.yAmnw3vJFXCFexSBIuAT"
}
