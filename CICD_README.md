## GitHub Actions Automation

### `deploy_infra.yml` Workflow Overview

This workflow automates the deployment of an EKS cluster using Terraform. It is triggered by commits pushed to the `main` branch and ensures that infrastructure changes are consistent and trackable.

### Environment

- **Runs-on**: `ubuntu-latest` — The workflow runs on the latest Ubuntu virtual environment provided by GitHub Actions.

### Workflow Jobs

#### Plan Job

- **Purpose**: Prepares a Terraform execution plan to preview changes without applying them.
- **Steps**:
  - **Checkout**: Clones the latest code from the GitHub repository to the GitHub Actions runner.
  - **Cache Terraform Modules**: Caches the Terraform modules and plugins to speed up execution and reduce download times on subsequent runs.
  - **Set up Terraform**: Installs Terraform version 1.5.7, ensuring consistency across runs.
  - **Configure AWS Credentials**: Sets up AWS credentials using secrets stored in GitHub, enabling Terraform to interact with AWS.
  - **Initialize Terraform**: Runs `terraform init` to initialize the working directory with necessary files and configurations.
  - **Validate Terraform Configuration**: Executes `terraform validate` to check if the configuration files are syntactically valid and internally consistent.
  - **Plan**: Generates a `terraform plan`, outputs the plan to a file called `tfplan`, and checks if any changes are detected.
  - **Upload Plan as Artifact**: If changes are detected (`plan-exists` is true), the plan file is uploaded as an artifact for use in the apply job.

#### Apply Job

- **Condition**: Only runs if the `plan` job has detected changes and the workflow is triggered on the `main` branch.
- **Steps**:
  - **Checkout**: Re-clones the repository to ensure the latest code is used.
  - **Download Terraform Plan**: Downloads the `tfplan` artifact from the plan job.
  - **Set up Terraform**: Reinstalls the same Terraform version used in the plan job to ensure consistency.
  - **Apply Terraform Changes**: Executes `terraform apply -auto-approve` using the downloaded plan, applying changes to the AWS environment to deploy or update the EKS cluster.

### Security Measures

- **AWS Credentials**: Managed securely using GitHub Secrets and scoped to the minimum required permissions to perform tasks.
- **Artifact Handling**: Terraform plans are stored temporarily as artifacts and are used only within the workflow to maintain security and traceability.

### Usage

To trigger this workflow, push changes to the `main` branch. Ensure that any modifications in the Terraform configurations are thoroughly reviewed and tested in a separate branch before merging to `main`.

This automation enhances the reliability and speed of EKS deployments, ensuring that infrastructure changes are consistently applied and version-controlled.
