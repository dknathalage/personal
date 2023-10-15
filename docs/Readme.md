## Start kubernetes

### Minikube and Service
- `minikube start`
- `kubectl create secret docker-registry regcred --docker-username=dknathalage --docker-password=*** --docker-email=dknathalage@gmail.com`

### Istio
- `helm repo add istio https://istio-release.storage.googleapis.com/charts`
- `helm repo update`
- `kubectl create namespace istio-system`
- `helm install istio-base istio/base -n istio-system --set defaultRevision=default`
- `helm install istiod istio/istiod -n istio-system --wait`
- `kubectl create namespace istio-ingress`
- `helm install istio-ingress istio/gateway -n istio-ingress --wait`
