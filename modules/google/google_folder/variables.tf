variable "folder_name" {
  type        = string
  description = "Name for the top level division. ex: topl-labs."
}

variable "parent" {
  type        = string
  description = "Parent for the folder. Can be another an organization, or another folder."
}
