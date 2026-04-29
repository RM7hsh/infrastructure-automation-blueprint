## CI/CD Pipeline

The project includes a basic CI/CD pipeline defined using **GitHub Actions**. This pipeline runs on every push to the `main`, `develop` and any `feature/*` branches and for all pull requests. The pipeline currently performs the following checks:

1. **Terraform Format Check**: Validates that all Terraform code is formatted consistently using `terraform fmt -check`. Fails the build if any file needs reformatting.
2. **Ansible Lint**: Installs Ansible and runs `ansible-lint` against all Ansible playbooks and roles to ensure they adhere to best practices.
3. **Docker Compose Build**: Builds all services defined in `docker/docker-compose.yml` to verify that the Dockerfiles and image definitions remain functional.

### Extending the pipeline

The CI/CD workflow can be extended as the project matures. Some potential enhancements:

* **Unit tests for Ansible roles** using `molecule`.
* **Integration tests** that provision the stack on a temporary environment and validate connectivity.
* **Static code analysis** on Dockerfiles using `hadolint` and on shell scripts using `shellcheck`.
* **Automatic documentation build** with a tool like MkDocs to verify that the documentation compiles.

Refer to `.github/workflows/ci.yml` for the current pipeline definition.
