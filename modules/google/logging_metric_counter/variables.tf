variable "metric_project_id" {
  description = "project_id where the logs are"
  type        = string
}

variable "metric_kind" {
  description = "(Required) Whether the metric records instantaneous values, changes to a value, etc. Some combinations of metricKind and valueType might not be supported. For counter metrics, set this to DELTA. Possible values are DELTA, GAUGE, and CUMULATIVE"
  type        = string
  default     = "DELTA"
}

variable "metric_type" {
  description = ""
  type        = string
  default     = "STRING"
}

variable "labels" {
  description = "labels to extract from log message"
  type        = any
}

variable "metric_name" {
  description = "name of the logging metric name"
  type        = string
}

variable "filter" {
  description = "filter for the metric"
  type        = string
}

variable "unit" {
  type        = string
  description = "The unit in which the metric value is reported. It is only applicable if the valueType is INT64, DOUBLE, or DISTRIBUTION. The supported units are a subset of The Unified Code for Units of Measure standard"
}
