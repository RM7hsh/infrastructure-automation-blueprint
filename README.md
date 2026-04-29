# Senior Infrastructure Automation Blueprint

This repository provides a **reference implementation** for building and operating a modern multi‑tier infrastructure using Infrastructure as Code (IaC) principles.  It combines **Terraform**, **Ansible**, **Docker**, **GitHub Actions** and modern monitoring/observability tools to create a reproducible, secure and observable environment suitable for enterprise workloads.  The goal is to showcase a realistic senior‑level approach to infrastructure automation – including modular code, clear abstractions and an opinionated Git workflow with feature branches and merge commits.

## Project Scope

The goal of this project is to provision and configure a small but complete infrastructure consisting of:

- Virtual machines on a Proxmox or other KVM‑based hypervisor using **Terraform** and **cloud‑init**
- Configuration management of operating systems and services using **Ansible**
- Deployment of application components and support services (database, backend API, frontend, proxy, monitoring) using **Docker**
- Observability stack using **Prometheus**, **Grafana**, **Alertmanager** and **Node Exporter**
- Documentation and diagrams describing the architecture, deployment process and operational practices

This repository is designed to be extensible.  It can be used as a starting point for your own experiments or as a blueprint for production.  Each component is modular and can be enabled or disabled as needed.

## Directory Structure

```
├── ansible/              # Ansible playbooks, roles and inventories
├── docs/                 # Architectural diagrams and documentation
├── terraform/            # Terraform modules and environment configurations
├── docker/               # Docker Compose files for application and monitoring stack
├── .github/             # GitHub Actions workflows for CI/CD
├── .gitignore            # Files/directories to ignore in git
├── README.md             # Project overview (you are here)
```

## How to Get Started

1. **Clone this repository** into your workstation and ensure you have the required tools installed: `git`, `terraform`, `ansible`, and `docker`/`docker‑compose`.
2. Review the `docs/architecture.md` document to understand the design and components.
3. Use Terraform to provision the infrastructure (e.g. VMs on Proxmox or another hypervisor).
4. Use Ansible to configure the base operating system and install dependencies.
5. Deploy the application and monitoring stack using Docker Compose.

### Continuous Integration / Continuous Delivery

This repository includes an example **CI/CD pipeline** defined in `.github/workflows/ci.yml`.  The pipeline runs automatically on pushes and pull requests to ensure that:

* Terraform code is properly formatted (`terraform fmt`)
* Ansible playbooks pass linting (`ansible-lint`)
* Docker Compose services build successfully

Future enhancements could include unit tests for Ansible roles, integration tests, security scanning, and automated documentation builds.  See `docs/ci_cd.md` for more details.

### Prerequisites

* A hypervisor or cloud provider that supports cloud‑init for provisioning (e.g. **Proxmox**, **VMware**, **OpenStack**, etc.)
* Access to an SSH key pair for provisioning VMs
* A recent version of **Terraform** (>= 1.3) and **Ansible** (>= 2.13)
* Basic knowledge of **Linux networking**, **systems administration** and **DevOps tools**

## Contributing & Workflow

This repository is intentionally structured to demonstrate a professional Git workflow.  Feature work happens on topic branches prefixed by `feature/` which are merged back into `develop` via Pull Requests.  Releases are cut from `main` after integrating `develop` with a non‑fast‑forward merge.  Tagging is used to mark release points.  Browse the commit history to see examples of branching strategies, merge commits, and meaningful commit messages.

Pull requests and issues are welcome.  When contributing, please:

1. Fork this repository or create a new feature branch from `develop`.
2. Make your changes with clear commit messages explaining the **what** and **why**.
3. If your change affects infrastructure code, ensure that `terraform fmt`, `ansible-lint` and `docker compose build` pass locally.
4. Open a pull request targeting `develop` and describe the rationale and testing steps.

A `CONTRIBUTING.md` document will be added to the `docs/` directory with coding standards and commit guidelines.

## License

This project is licensed under the MIT License.  See the `LICENSE` file for details.