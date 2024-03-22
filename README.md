# Terraform Repository

This repository contains Terraform configuration files for managing infrastructure resources.


## Directory Structure

The directory structure consists of the following components:

- **dev**, **prod**, **qa**, **stage**: These directories represent different environments (development, production, quality assurance, staging) where infrastructure is deployed using Terraform.

- **global**: Contains configurations that are applied globally, not specific to any environment.

- **modules**: Contains reusable Terraform modules that define infrastructure components.

## Components

Within each environment directory, there are subdirectories for different components of the infrastructure:

- **ecs-cluster**: Defines configurations related to ECS clusters.

- **iam**: Contains IAM (Identity and Access Management) related configurations.

- **rds**: Includes configurations for Amazon RDS (Relational Database Service) instances.

- **security-groups**: Contains configurations for security groups.

- **vpc**: Defines configurations related to Virtual Private Clouds (VPCs).

- **web-service**: Includes configurations for web services.

## Files

Each component directory contains the following files:

- **main.tf**: The main Terraform configuration file defining the infrastructure resources.

- **terraform.tfvars**: Contains variable definitions for the Terraform configuration.

- **variables.tf**: Defines input variables used in the Terraform configuration.

Additionally, there are some directories under the **modules** directory, each containing a set of Terraform modules for specific functionalities (e.g., IAM, ECS, RDS, etc.).

This directory structure organizes Terraform configurations based on different environments and components, allowing for easier management and deployment of infrastructure.