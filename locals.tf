locals {
  forced_context = {
    bind_address = "* -::*"
    port         = 6379
  }
}
