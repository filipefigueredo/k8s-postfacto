# TODO

## Ingress (App)

- Deploy a cert-manager service to handle Let's encrypt certificates
- Create a new helm chart to automate ingress routes and services deployments
- Deploy another ingress that handles the `X-POSTFACTO-VERSION` natively (ambassador, Traefik, etc)
- Automate controller.service.loadBalancerIP variable to get the lb IP

## Postfacto

- Improve postfacto chart to accept multiple versions
- Add ingress external service to postfacto chart

## Helmfile

- Handle some passwords an secrets that were hardcoded for the sake of the tests

## PV and PVC

- Create a chart to automate PV and PVC at K8s cluster

## Terraform

- Refactor terraform to be reusable using module concepts
- Add LoadBalancer, and Kubernetes network
- Recheck all resources dependencies
- Move all helmfile deployments to terraform using Helm provisioner
