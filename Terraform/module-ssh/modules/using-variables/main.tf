variable "var" {}

variable "list" {
  type = list(string)
}

variable "complex" {
  type = list(object({
    simple = number
    text = string
  }))
}

# variable "regex" {
#   type = string
#   description = "Simple module variable based on regex"

#   validation {
#     condition = can(regex("^test", var.regex))
#     error_message = "Regex variable value must start witth test"
#   }
# }

variable "default" {
  default = "default value"
}

output "module-variables-output" {
  value = "test"
}