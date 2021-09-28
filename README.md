<h1 align="center">Welcome to postfacto-k8s 👋</h1>
<p>
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

## Overview

This project is a tailored solution for `Postfacto` app deployment with the following prerequisites in mind:

- Postfacto must be accessible from the internet through HTTPS.
- Postfacto persistent data must be stored in a way that in case of node or cluster failure, the same data will not be lost.
- The Postfacto app pods cannot be deployed on the same nodes as the database and Redis.
- To satisfy the QA team, we need to run two versions, 4.1.0 and 4.2.0, of the Postfacto app on the same cluster simultaneously.
- Postfacto must route requests based on X-POSTFACTO-VERSION HTTP header value, to the pods that contains the correspondent version of the app.

The following pre-requisites were added at a later stage of the project:

- Enable ingress auto-scaler to allow ingress to handle bursts of high-demand requests:
- Separate concerns using namespaces:

  - Postfacto should have its own namespace to deal with application-specific issues.
  - Ingress should have its own namespace dedicated to routing issues.

- Create distinct nodepools for each type of pod, taking into account the amount of resources consumed and the level of reliability required for each workload:
  - Databases and cache resources should be deployed in a nodepool with more IOPS and memory;
  - Postfacto applications should be deployed in a nodepool with no special requirements;
  - Critical cluster resources like cored-dns, ingress, and any authentication resource must be deployed in a nodepool of type system;

## Diagram

![Postfacto Architecture](/postfacto.drawio.png)

## Deployment

### Pre-requisites

#### Necessary tools

1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to your local machine
2. Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) to your local machine

#### Azure pre-requisites

5. A [Azure account](https://azure.microsoft.com/en-us/)
6. A [service principal](https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal?tabs=azure-cli) for provisioning the required resources for AKS cluster.
7. A configured [storage](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli) to secure your Terraform state. If necessary, your should go to main.tf and reconfigure backend to match you storage configuration.

### Provisioning the infrastructure and deploying the applications

```bash
$ cd terraform

# Initialize directory, pull down providers
$ terraform init

# output the deployment plan to plan.out
$ terraform plan -out plan.out

# Apply use the plan.out plan file to provision infrastructure
$ terraform <plan file> apply

# Provision infrastructure without plan file
$ terraform  apply
```

> Note: Your going to be prompted to enter credential related variables. You can handle it by using environment variables to set [variables](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name)

## Testing the application

### Admin dashborad

For testing purposes, a default admin user `example@example.com` with password `password` is created when the postfacto pod spin up.

The admin dashboard will be available at <http://postfacto.api0.live/admin>.

### Retros

The retro will be available at <http://postfacto.api0.live/retros/your-retro-slug`>.

## TODO

Please see [TODO.md](TODO.md).

## Author(s)

👤 **Filipe Figueredo Silva**

## 📝 License

This project is [MIT](LICENSE.md) licensed.
