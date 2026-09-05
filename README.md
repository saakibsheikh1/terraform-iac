\# Terraform Infrastructure as Code



Infrastructure as Code project using Terraform to provision, manage, and reproduce AWS infrastructure safely and consistently.



\## Project Overview



This project demonstrates a production-oriented Terraform workflow covering:



\* Infrastructure provisioning with Terraform

\* Reusable Terraform modules

\* Remote Terraform state using Amazon S3

\* State locking using DynamoDB

\* Safe `plan` and `apply` workflows

\* Environment isolation for Dev and Staging

\* Infrastructure drift detection and reconciliation

\* GitHub Actions CI/CD integration

\* Infrastructure teardown and reproducibility

\* Secure handling of sensitive values and outputs



The goal is to demonstrate infrastructure that is \*\*version-controlled, reviewable, repeatable, and safe for team use\*\*.



\## Architecture



The project provisions a multi-resource AWS environment using Terraform.



```text

&#x20;                   GitHub Repository

&#x20;                          |

&#x20;                          v

&#x20;                   Terraform Code

&#x20;                          |

&#x20;             +------------+------------+

&#x20;             |                         |

&#x20;             v                         v

&#x20;       Dev Environment         Staging Environment

&#x20;             |                         |

&#x20;             +------------+------------+

&#x20;                          |

&#x20;                          v

&#x20;                   Reusable Modules

&#x20;                    /           \\

&#x20;                   v             v

&#x20;               Network        Compute

&#x20;                  |

&#x20;                  v

&#x20;             AWS Resources



Terraform State

&#x20;      |

&#x20;      v

&#x20;  Amazon S3

&#x20;      |

&#x20;      +---- State Versioning

&#x20;      |

&#x20;      +---- DynamoDB Locking

```



\## Repository Structure



```text

terraform-iac/

│

├── README.md

│

├── modules/

│   ├── network/

│   └── compute/

│

├── environments/

│   ├── dev/

│   └── staging/

│

├── backend/

│

├── ci/

│

└── docs/

&#x20;   ├── iac-report.md

&#x20;   ├── research.md

&#x20;   ├── runbook.md

&#x20;   └── screenshots/

```



\## Project Stages



\### Stage 1 — Terraform Configuration and Remote State



\* Provision AWS networking and compute resources using Terraform.

\* Configure an S3 backend for remote Terraform state.

\* Configure DynamoDB state locking.

\* Enable S3 versioning for state recovery.

\* Demonstrate that concurrent Terraform operations are protected by state locking.



\### Stage 2 — Reusable Modules



\* Build reusable network and compute modules.

\* Define module inputs and outputs.

\* Use the same modules for Dev and Staging environments.

\* Control environment differences through variables.

\* Document the module interfaces.



\### Stage 3 — Plan/Apply Workflow



\* Format Terraform configuration using `terraform fmt`.

\* Validate configuration using `terraform validate`.

\* Review changes using `terraform plan`.

\* Demonstrate in-place updates and resource replacement.

\* Maintain separate state/environment isolation.

\* Use Terraform plans as review artifacts for pull requests.



\### Stage 4 — Drift Detection



\* Introduce an intentional infrastructure change outside Terraform.

\* Detect the drift using `terraform plan`.

\* Demonstrate reconciliation by either:



&#x20; \* reverting AWS infrastructure to the Terraform configuration, or

&#x20; \* updating Terraform configuration to reflect the intended change.

\* Configure periodic drift detection through CI.



\### Stage 5 — CI Integration and Reproducibility



\* Run Terraform plans on pull requests.

\* Apply approved changes after merging to `main`.

\* Perform scheduled drift checks.

\* Destroy the complete environment using Terraform.

\* Recreate the environment from the Terraform code.

\* Verify that the recreated environment is consistent with the declared configuration.

\* Handle sensitive outputs and secrets appropriately.



\## Terraform Workflow



```text

Developer makes change

&#x20;       |

&#x20;       v

terraform fmt

&#x20;       |

&#x20;       v

terraform validate

&#x20;       |

&#x20;       v

terraform plan

&#x20;       |

&#x20;       v

Review planned changes

&#x20;       |

&#x20;       v

Pull Request

&#x20;       |

&#x20;       v

Merge to main

&#x20;       |

&#x20;       v

terraform apply

```



\## Remote State



Terraform state is stored remotely in Amazon S3 rather than locally.



The backend provides:



\* Centralized state

\* State versioning

\* Team accessibility

\* State locking

\* Protection against conflicting Terraform operations



DynamoDB is used for state locking so concurrent Terraform operations do not modify the same state simultaneously.



\## Environments



The project contains two environments:



```text

environments/

├── dev/

└── staging/

```



Both environments use the same reusable modules while their configuration differences are controlled through variables.



This avoids maintaining separate copies of infrastructure code.



\## Drift Detection



Infrastructure drift occurs when the actual AWS infrastructure differs from the configuration declared in Terraform.



Example:



```text

Terraform configuration

&#x20;       |

&#x20;       | expected configuration

&#x20;       v

&#x20;  AWS Resource



&#x20;       X



Manual AWS Console Change

&#x20;       |

&#x20;       v

Actual configuration differs

&#x20;       |

&#x20;       v

terraform plan

&#x20;       |

&#x20;       v

Drift detected

```



The project demonstrates both reverting unintended drift and updating Terraform when a manual change is intentionally adopted.



\## CI/CD



GitHub Actions is used to integrate Terraform into the development workflow.



Expected workflow:



```text

Pull Request

&#x20;    |

&#x20;    v

Terraform Format

&#x20;    |

&#x20;    v

Terraform Validate

&#x20;    |

&#x20;    v

Terraform Plan

&#x20;    |

&#x20;    v

Review

&#x20;    |

&#x20;    v

Merge to main

&#x20;    |

&#x20;    v

Terraform Apply

```



Periodic Terraform plans are also used to identify infrastructure drift.



\## Security



The project follows these practices:



\* No access keys or passwords committed to Git.

\* Sensitive Terraform outputs are marked appropriately.

\* AWS credentials are handled through secure CI mechanisms.

\* Screenshots are sanitized before being committed.

\* Account IDs, ARNs, credentials, and other sensitive information are not exposed.



\## Documentation



Additional project documentation is stored under `docs/`.



```text

docs/

├── iac-report.md

├── research.md

├── runbook.md

└── screenshots/

```



\### `iac-report.md`



Contains:



\* Resources managed

\* Module structure

\* Backend and locking configuration

\* Drift detected and resolution

\* Most difficult resource type to manage cleanly



\### `research.md`



Contains the comparison of:



\* Terraform

\* AWS CloudFormation

\* AWS CDK



It also documents the importance of remote state and locking.



\### `runbook.md`



Contains the troubleshooting procedure for an unintended Terraform resource replacement, such as a database being planned for destruction and recreation.



\## Cleanup



All infrastructure created for this project must be removed after the project has been reviewed.





terraform destroy

```



The final project evidence should confirm that the test environment has been cleaned up.



\## Status



\*\*Project:\*\* Infrastructure as Code with Terraform

\*\*Repository:\*\* `terraform-iac`

\*\*Environment:\*\* AWS personal test account

\*\*Status:\*\* In Progress



\## Author

## Terraform Workflow

The project follows a controlled Infrastructure as Code workflow:

Code Change
    ↓
Terraform fmt
    ↓
Terraform validate
    ↓
Terraform plan
    ↓
Pull Request Review
    ↓
Merge to main
    ↓
Terraform Apply
    ↓
Drift Detection


\*\*Sakib Sheikh\*\*



