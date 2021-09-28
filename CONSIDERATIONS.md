# Overview

This document is an attempt to explain some of the decisions and tradeoffs made during development as a result of the time constraints.

## Short brief of the development phases

Here's a quick rundown of the project's development history, along with some additional justifications for each decision:

1. I began by reviewing the documentation and attempting to run the application locally. I set up a local development container, inspected the code as thoroughly as possible, and attempted to work with Redis and postgreSQL. I decided to continue on and test postfacto using helm charts after noting that certain headers were not implemented as environment variables or configurations. I wasn't familiar with the chart and dependencies, so it took some time to inspect the correct version of of the charts documentation (some variables changed during the evolution of Redis and postegreSQL charts).I wasn't able to handle the persistence requirement at this time, so I opted to move on and check it later (rather than configuring persistence globally in the chart, I tried to configure master/slaves separately, which didn't work).

2. After installing the first helm chart, decided to create a new postfacto release then I realize that would be necessary some modifications at the chart since it always uses the image that you choose with the "latest" tag. Experimented some other modifications with the chart regarding Redis and PostgresSQL and created the second release. Installed ingress nginx to solve the headers issue. Since I had some prior experience using configurations snippet with ingress-nginx, I've decide to solve the headers using [`proxy_pass`](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) directive (kind of adhoc solution, but I couldn't see other solutions with ingress-nginx). I was aware that other ingresses, such as Traefik or Ambassador, may address this problem, but I chose to continue with nginx.

3. I configured nginx to handle https requests and redirect http queries, added the postfacto.api0.live host to configurations, then attempted to configure cert-manager to administer TLS/SSL certificates but failed.I'd have to configure it via webhooks because the domain provider doesn't support DNS01 challenge providers.I've decided to move on and use a nginx container to generate a Let's Encrypt certificate (this will work for the next three months, till I learn more about how to implement the webhook or find a better solution like this [one](https://github.com/snowdrop/godaddy-webhook).

4. At this point, both the ingress and postfacto apps were working properly. I decided to keep ingress and postfacto applications in separate namespaces. This method is ideal for situations where you want to build a namespace for the application that can be handled by a local team, while another namespace is in charge of all public routes and routing logic. In cases that no headers fit the ingress rule, a fallback external service was created that forwarded requests to postfacto v2.

5. Came back to the persistence volume issue. Inspected the postfacto dependencies charts and realize that the persistence configurations was quite simple and made it work with dynamic volumes. Decided to create persistent volumes manually using azure managed disks to prevent cases where a total disaster can happen with a cluster. Created the [PVs and PVCs](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) YAMLs and deployed it manually for instance. The PVC and PV worked but I had some trouble attaching azure disk to postfacto deployments.

6. After resolving the persistence issue, the database pods were separated from the application pods. To solve this, a common pattern is to use a combination of taints / tolerations, podAffinity / podAntiAffinity.
   This is a good idea, but I've decided to go with a simpler strategy that will allow me to scale the cluster properly. It was decided to set up a database-specific nodepool and an application-specific nodepool.
   The idea behind was to give a correct approach to address each workload: databases require more memory and disk space, whereas applications gain more from nodes with more CPUs (or even GPU in some cases), leading to a complete different virtual machine scale-sets.

7. Up until that time, all deployments had been created by manually installing each Helm file secrets, configMaps, services, and volumes manually. To deploy all helm releases provided in a helmfile.yaml file, I decided to utilize the `helmfile` tool. In addition, the infrastructure was manually provisioned. I started with some ARM templates, then abandoned that option in favor of Terraform.

8. Terraform was used to construct all helm releases, however the services, ingress routes settings, persistent volumes claims, and persistent volumes were all done manually.

9. Using the Kubernetes provider, added services, ingress route settings, persistent volume claims, and persistent volumes to Terraform.
