# TerraformV2 Infrastructure

Modern, modular Terraform infrastructure supporting multiple environments with proper separation of concerns.

## Structure

```
terraformV2/
├── environments/          # Environment-specific configurations
│   ├── dev/              # Development environment
│   ├── test/             # Test environment  
│   ├── prod/             # Production environment
│   └── shared-services/  # Shared tools and services
└── modules/              # Reusable infrastructure modules
    ├── networking/       # VPC, subnets, routing
    ├── compute/          # EC2, EKS resources
    ├── security/         # IAM, security groups
    └── applications/     # Application infrastructure
```

## Quick Start

### Deploy Test Environment
```bash
cd environments/test
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Deploy Jenkins (Shared Services)
```bash
cd environments/shared-services
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Environment Strategy

- **Per-environment Jenkins**: Each environment has isolated Jenkins instance
- **Shared services**: Cross-environment tools in dedicated environment
- **Complete isolation**: Separate state files and resources per environment

## Module Usage

Modules are designed to be reusable across environments with different configurations:

```hcl
module "networking" {
  source = "../../modules/networking"
  
  environment = "test"
  vpc_cidr    = "10.1.0.0/16"
  az_count    = 3
}
```

## Architecture Decision

See [ADR-001](../architectureV2/ADR-001-terraform-structure.md) for detailed rationale behind this structure.