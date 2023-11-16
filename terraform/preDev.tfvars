environment = "predev"
aws_region  = "ca-central-1"
app_name    = "retail"

image_builder_map = {
  # rhel_sap_8_8 = {
  #     app_name = "RHEL"
  #     operating_system = "RHEL"
  #     final_usage_of_ami = "SAP"

  #     base_ami = "rhel_8.8_sap"
  # target_account_ids = ["654919738084"]
  # versions = {
  #         "1": "1.0.0"
  #     }
  # version_to_publish = "1"
  # }
  oel_sap_8_8 = {
    app_name           = "OEL"
    operating_system   = "OEL"
    final_usage_of_ami = "SAP-and-Oracle"

    base_ami = "oel_8.8_sap"

    target_account_ids = ["654919738084"]

    versions = {
      "v1.0.0" : "1.0.0"
    }
    version_to_publish = "v1.0.0"
  }
}
