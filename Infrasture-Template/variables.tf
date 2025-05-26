variable "resource_group_name" {
    type = string
    default = "demo_rg"
  }

  variable "environment" {
    type = string
    default = "staging"
  }

  variable "location" {
    type = string
    default = "eastus2"
  }

  variable "vnet_name" {
    type = string
    default = "demo_vnet"
  }

  variable "subnet-name" {
    type = string
    default = "demo_subnet-vm"
  }

  variable "subnet-ag-name" {
    type = string
    default = "demo_subnet-ag"
  }
  variable "application-gw" {
    type = string
    default = "demo-appl-gw"
  }

  variable "load-bal" {
    type = string
    default = "demo-lb"
  }

  variable "public-ip" {
    default = "demo-pubic-ip"
  }

  variable "load-balancer"{
    default = "Internal-lb"
  }

