# ADR-001: Terraform Infrastructure Structure and Multi-Environment Strategy

## Status
Accepted

## Date
2025-09-14

## Context
We need to restructure our Terraform infrastructure to support multiple environments (dev, test, prod) with proper separation of concerns, reusable modules, and shared services management.

### Current Problems
- Monolithic Terraform structure in single directory
- No environment separation
- Difficulty in managing shared services like Jenkins
- Code duplication across environments
- No clear module boundaries

### Requirements
- Support for multiple environments (dev, test, prod)
- Reusable infrastructure modules
- Proper separation of shared services
- Environment-specific configurations
- Scalable and maintainable structure

## Decision

### 1. Directory Structure
```
terraformV2/
├── environments/
│   ├── dev/
│   ├── test/
│   ├── prod/
│   └── shared-services/
└── modules/
    ├── networking/
    ├── compute/
    │   ├── ec2/
    │   └── eks/
    ├── security/
    │   ├── iam/
    │   └── security-groups/
    └── applications/
        └── jenkins/
```

### 2. Environment Strategy
- **Separate Jenkins per environment**: Each environment (dev, test, prod) has its own Jenkins instance
- **Shared services environment**: For cross-environment tools like monitoring, logging, shared databases
- **Environment isolation**: Complete separation of resources and state files

### 3. Module Organization
- **networking**: VPC, subnets, routing, VPC endpoints
- **compute**: EC2 instances, EKS clusters, auto-scaling groups
- **security**: IAM roles/policies, security groups, NACLs
- **applications**: Application-specific infrastructure (Jenkins, monitoring tools)

### 4. Configuration Management
- Environment-specific `terraform.tfvars` files
- Separate backend configurations per environment
- Version constraints in `versions.tf` files
- Consistent variable naming across modules

## Consequences

### Positive
- **Environment Isolation**: Complete separation prevents cross-environment issues
- **Reusability**: Modules can be reused across environments with different configurations
- **Scalability**: Easy to add new environments or services
- **Maintainability**: Clear separation of concerns and responsibilities
- **Security**: Environment-specific IAM roles and policies
- **CI/CD Ready**: Structure supports automated deployments per environment

### Negative
- **Complexity**: More files and directories to manage
- **Initial Setup**: Requires migration from current structure
- **Resource Duplication**: Each environment has its own Jenkins (higher cost)
- **State Management**: Multiple state files to manage

### Neutral
- **Learning Curve**: Team needs to understand new structure
- **Documentation**: Requires comprehensive documentation for new structure

## Implementation Plan

### Phase 1: Module Creation
1. Create networking module (VPC, subnets, routing)
2. Create security modules (IAM, security groups)
3. Create compute modules (EC2, EKS)
4. Create Jenkins application module

### Phase 2: Environment Setup
1. Set up dev environment first
2. Migrate test environment
3. Set up prod environment
4. Create shared-services environment

### Phase 3: Migration
1. Export existing resources
2. Import into new structure
3. Validate functionality
4. Decommission old structure

## Alternatives Considered

### Single Jenkins for All Environments
- **Pros**: Cost-effective, centralized management
- **Cons**: Single point of failure, security concerns, environment coupling
- **Decision**: Rejected due to security and isolation concerns

### Workspace-based Environments
- **Pros**: Single codebase, Terraform workspaces
- **Cons**: Shared state backend, limited isolation, complex variable management
- **Decision**: Rejected in favor of directory-based separation

### Monorepo vs Multi-repo
- **Decision**: Monorepo chosen for easier cross-module dependencies and unified versioning

## References
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)