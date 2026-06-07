<!-- header start -->

<a href="https://stackoverflow.com/users/1755598/codewizard"><img src="https://stackoverflow.com/users/flair/1755598.png" width="208" height="58" alt="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers"></a>&emsp;&emsp;[![Linkedin Badge](https://img.shields.io/badge/-nirgeier-blue?style=flat&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/nirgeier/)](https://www.linkedin.com/in/nirgeier/)&emsp;[![Gmail Badge](https://img.shields.io/badge/-nirgeier@gmail.com-fcc624?style=flat&logo=Gmail&logoColor=red&link=mailto:nirgeier@gmail.com)](mailto:nirgeier@gmail.com)&emsp;[![Outlook Badge](https://img.shields.io/badge/-nirg@codewizard.co.il-fcc624?style=flat&logo=microsoftoutlook&logoColor=blue&link=mailto:nirg@codewizard.co.il)](mailto:nirg@codewizard.co.il)

<!-- header end -->

---

# Docker Compose to Helm - From Development to Kubernetes

- This lab teaches you how to **convert Docker Compose applications into Helm charts** for Kubernetes deployment.
- You'll learn Helm fundamentals, chart structure, templating, and how to map Compose concepts to K8s resources.
- The lab includes **6 complete Helm charts** for a production monitoring stack (Grafana, Loki, Prometheus, etc.).
- This lab bridges the gap between Docker Compose (development) and Kubernetes (production) by teaching you how to package your compose applications as Helm charts.
- You'll start with a Docker Compose monitoring stack and convert it to deployable Helm charts.

---

![](../../resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)
**<kbd>CTRL</kbd> + click to open in new window**

---

[![Download Lab ZIP](https://img.shields.io/badge/📥-Download_Lab_ZIP-blue?style=for-the-badge)](004-Compose-2Helm.zip)

---

## Description

Helm is the Kubernetes package manager. This lab walks through the complete workflow: from a Docker Compose monitoring stack (Grafana, Loki, Prometheus, Node Exporter, Portainer, and a Node.js server) to fully functional Helm charts. Each chart includes deployment, service, and configuration templates that mirror the original Compose service definitions.

## Prerequisites

| Requirement | Details |
|------------|---------|
| **Kubernetes Cluster** | Any K8s cluster (minikube, kind, Docker Desktop, or remote) |
| **Helm v3+** | [Install Helm](https://helm.sh/docs/intro/install/) |
| **kubectl** | Configured to communicate with your cluster |
| **Docker Compose** | Basic understanding (covered in Labs 001-003) |

---

## What You'll Learn

- [ ] Understand Helm chart structure and core concepts
- [ ] Map Docker Compose concepts to Kubernetes resources
- [ ] Use Helm templates with Go templating syntax
- [ ] Create deployment, service, configmap, and ingress templates
- [ ] Set up resource limits, health checks, and environment variables
- [ ] Package and deploy charts to Kubernetes
- [ ] Manage releases with upgrade, rollback, and uninstall
- [ ] Use dependency management with subcharts

---

## Docker Compose vs Helm Concepts

| Docker Compose      | Kubernetes / Helm                                     |
|---------------------|-------------------------------------------------------|
| `services:`         | `Deployment` + `Service` + `ConfigMap`                |
| `image:`            | `image:` in deployment template with registry         |
| `ports:`            | `containerPort` + `Service` port mapping              |
| `environment:`      | `env:` or `envFrom` in deployment template            |
| `volumes:`          | `PersistentVolumeClaim` + `volumeMounts`              |
| `networks:`         | Kubernetes networking (automatically flat)            |
| `depends_on:`       | `initContainers` + readiness probes                   |
| `healthcheck:`      | `livenessProbe` + `readinessProbe`                    |
| `restart:`          | `restartPolicy` in pod spec                           |
| `deploy.resources:` | `resources.limits` + `resources.requests`             |
| `.env` file         | `values.yaml` + `--set` overrides                     |
| `extends:`          | Helm subcharts + `import-values`                      |
| `profiles:`         | Helm conditional flags (`--set service.enabled=true`) |

---

## The Monitoring Stack Helm Charts

This lab includes **6 pre-built Helm charts** in `helm-charts/`:

| Chart           | Description              | Docker Compose Base                    |
|-----------------|--------------------------|----------------------------------------|
| `grafana`       | Grafana 10.4.0 dashboard | `resources/compose/grafana.yaml`       |
| `loki`          | Loki log aggregation     | `resources/compose/loki.yaml`          |
| `node-exporter` | Prometheus node metrics  | `resources/compose/node-exporter.yaml` |
| `portainer`     | Container management UI  | `resources/compose/portainer.yaml`     |
| `prometheus`    | Metrics collection       | `resources/compose/prometheus.yaml`    |
| `server`        | Node.js demo application | `resources/compose/server.yaml`        |

### Chart Structure

Each chart follows the standard Helm layout:

```
helm-charts/<name>/
├── Chart.yaml          # Metadata (name, version, description)
├── values.yaml         # Default configuration values
├── templates/
│   ├── _helpers.tpl    # Reusable template helpers (NEW)
│   ├── deployment.yaml # Kubernetes Deployment
│   ├── service.yaml    # Kubernetes Service
│   ├── configmap.yaml  # Configuration data (NEW)
│   ├── ingress.yaml    # External access (NEW)
│   ├── hpa.yaml        # Auto-scaling (NEW)
│   ├── pvc.yaml        # Persistent storage (NEW)
│   └── NOTES.txt       # Post-install notes (NEW)
```

!!! tip "Mirroring Compose to K8s"
    Each section in the original Compose file maps to one or more K8s resources. Use the comparison table above as a reference when converting your own applications.

---

## Step-by-Step: Converting Compose to Helm

### Step 1: Identify Services and Dependencies

Start by listing all services in your `docker-compose.yml` and their dependencies.

```yaml
# Original compose snippet (from resources/compose/grafana.yaml)
version: "3.8"
services:
  grafana:
    image: grafana/grafana:10.4.0
    restart: unless-stopped
    ports:
      - "${GRAFANA_PORT}:3000"
    environment:
      - GF_AUTH_ANONYMOUS_ORG_ROLE=${GF_AUTH_ANONYMOUS_ORG_ROLE}
      - GF_AUTH_ANONYMOUS_ENABLED=${GF_AUTH_ANONYMOUS_ENABLED}
      - GF_AUTH_BASIC_ENABLED=${GF_AUTH_BASIC_ENABLED}
    healthcheck:
      test: ["CMD", "sh", "-c" ,"curl -s -f -o /dev/null http://localhost:3000 || exit 1"]
      interval: 10s
      timeout: 10s
      retries: 5
      start_period: 5s
    volumes:
      - ${GRAFANA_PROVISIONING_PATH}:/etc/grafana/provisioning
```

### Step 2: Map to Kubernetes Resources

| Compose Field | K8s Equivalent | File |
|--------------|----------------|------|
| `image` | `spec.template.spec.containers[].image` | `deployment.yaml` |
| `ports` | `containerPort` + `Service` | `deployment.yaml` + `service.yaml` |
| `environment` | `env` or `envFrom` | `deployment.yaml` |
| `healthcheck` | `livenessProbe` + `readinessProbe` | `deployment.yaml` |
| `volumes` | `volumeMounts` + `volumes` | `deployment.yaml` + `pvc.yaml` |
| `restart` | `restartPolicy` | `deployment.yaml` |
| Port exposure | `Ingress` | `ingress.yaml` |

### Step 3: Create the Helm Templates

#### `Chart.yaml`

```yaml
apiVersion: v2
name: grafana
description: A Helm chart for Grafana on Kubernetes
type: application
version: 0.1.0
appVersion: "10.4.0"
keywords:
  - monitoring
  - dashboards
  - grafana
sources:
  - https://github.com/grafana/grafana
maintainers:
  - name: Your Name
    email: your@email.com
```

#### `values.yaml`

```yaml
# Default values for grafana
replicaCount: 1

image:
  repository: grafana/grafana
  tag: "10.4.0"
  pullPolicy: IfNotPresent

nameOverride: ""
fullnameOverride: ""

service:
  type: ClusterIP
  port: 3000
  targetPort: 3000

ingress:
  enabled: false
  className: ""
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - host: grafana.local
      paths:
        - path: /
          pathType: Prefix
  tls: []

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 3
  targetCPUUtilizationPercentage: 80

env:
  GF_AUTH_ANONYMOUS_ENABLED: "true"
  GF_AUTH_ANONYMOUS_ORG_ROLE: "Admin"
  GF_AUTH_BASIC_ENABLED: "false"

probes:
  liveness:
    path: /api/health
    initialDelaySeconds: 30
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 3
  readiness:
    path: /api/health
    initialDelaySeconds: 5
    periodSeconds: 10
    timeoutSeconds: 3
    failureThreshold: 5

persistence:
  enabled: false
  size: 10Gi
  storageClass: ""
  accessMode: ReadWriteOnce

nodeSelector: {}
tolerations: []
affinity: {}
```

#### `templates/deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "grafana.fullname" . }}
  labels:
    {{- include "grafana.labels" . | nindent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "grafana.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "grafana.labels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "grafana.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          env:
            {{- range $key, $val := .Values.env }}
            - name: {{ $key }}
              value: {{ $val | quote }}
            {{- end }}
          ports:
            - name: http
              containerPort: {{ .Values.service.targetPort }}
              protocol: TCP
          livenessProbe:
            httpGet:
              path: {{ .Values.probes.liveness.path }}
              port: http
            initialDelaySeconds: {{ .Values.probes.liveness.initialDelaySeconds }}
            periodSeconds: {{ .Values.probes.liveness.periodSeconds }}
            timeoutSeconds: {{ .Values.probes.liveness.timeoutSeconds }}
            failureThreshold: {{ .Values.probes.liveness.failureThreshold }}
          readinessProbe:
            httpGet:
              path: {{ .Values.probes.readiness.path }}
              port: http
            initialDelaySeconds: {{ .Values.probes.readiness.initialDelaySeconds }}
            periodSeconds: {{ .Values.probes.readiness.periodSeconds }}
            timeoutSeconds: {{ .Values.probes.readiness.timeoutSeconds }}
            failureThreshold: {{ .Values.probes.readiness.failureThreshold }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          {{- with .Values.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
      {{- with .Values.volumes }}
      volumes:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
```

#### `templates/_helpers.tpl`

```yaml
{{/*
Expand the name of the chart.
*/}}
{{- define "grafana.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "grafana.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "grafana.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "grafana.labels" -}}
helm.sh/chart: {{ include "grafana.chart" . }}
{{ include "grafana.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "grafana.selectorLabels" -}}
app.kubernetes.io/name: {{ include "grafana.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
```

#### `templates/service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "grafana.fullname" . }}
  labels:
    {{- include "grafana.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: TCP
      name: http
  selector:
    {{- include "grafana.selectorLabels" . | nindent 4 }}
```

#### `templates/ingress.yaml`

```yaml
{{- if .Values.ingress.enabled -}}
{{- $fullName := include "grafana.fullname" . -}}
{{- $svcPort := .Values.service.port -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "grafana.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- with .Values.ingress.className }}
  ingressClassName: {{ . }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ $fullName }}
                port:
                  number: {{ $svcPort }}
          {{- end }}
    {{- end }}
{{- end }}
```

#### `templates/hpa.yaml`

```yaml
{{- if .Values.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "grafana.fullname" . }}
  labels:
    {{- include "grafana.labels" . | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "grafana.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
{{- end }}
```

#### `templates/pvc.yaml`

```yaml
{{- if .Values.persistence.enabled }}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "grafana.fullname" . }}
  labels:
    {{- include "grafana.labels" . | nindent 4 }}
spec:
  accessModes:
    - {{ .Values.persistence.accessMode }}
  resources:
    requests:
      storage: {{ .Values.persistence.size }}
  {{- if .Values.persistence.storageClass }}
  storageClassName: {{ .Values.persistence.storageClass }}
  {{- end }}
{{- end }}
```

#### `templates/NOTES.txt`

```text
Thank you for installing {{ .Chart.Name }}.

Your release is named {{ .Release.Name }}.

To learn more about the release, try:

  $ helm status {{ .Release.Name }}
  $ helm get all {{ .Release.Name }}

To access the application:

  export POD_NAME=$(kubectl get pods \
    --namespace {{ .Release.Namespace }} \
    -l "app.kubernetes.io/name={{ include "grafana.name" . }},app.kubernetes.io/instance={{ .Release.Name }}" \
    -o jsonpath="{.items[0].metadata.name}")

  kubectl --namespace {{ .Release.Namespace }} port-forward $POD_NAME 8080:3000
```

---

## Hands-On Tasks

### Task 1: Explore the Pre-built Helm Charts

```bash
# Navigate to the helm-charts directory
cd Labs/004-Compose-2Helm/helm-charts

# Explore the structure of each chart
for chart in */; do
  echo "=== $chart ==="
  cat "${chart}Chart.yaml"
  echo "---"
  head -5 "${chart}values.yaml"
  echo
done

# Validate each chart's templates
for chart in */; do
  helm lint "$chart"
done
```

**Expected Outcome:** All 6 charts pass `helm lint` validation.

---

### Task 2: Deploy a Single Chart

```bash
# Deploy the Grafana chart
cd grafana
helm install grafana-release .

# Verify the release
helm list
helm status grafana-release

# Check Kubernetes resources
kubectl get all -l "app.kubernetes.io/instance=grafana-release"

# Access Grafana (port-forward)
kubectl port-forward svc/grafana-release-grafana 3000:3000
# Open http://localhost:3000 in your browser

# Clean up
helm uninstall grafana-release
```

**Expected Outcome:** Grafana deploys successfully and is accessible via port-forward.

---

### Task 3: Customize Values

```bash
# Deploy with custom values
helm install grafana-release ./grafana \
  --set image.tag=10.4.0 \
  --set service.type=NodePort \
  --set resources.limits.cpu=1 \
  --set resources.limits.memory=1Gi \
  --set env.GF_AUTH_ANONYMOUS_ENABLED=false

# Verify the values were applied
helm get values grafana-release

# Check the rendered templates
helm get manifest grafana-release | grep -A5 "resources:"

# Clean up
helm uninstall grafana-release
```

**Expected Outcome:** Custom values override defaults in the deployed resources.

---

### Task 4: Create a New Helm Chart from Scratch

```bash
# Create a new chart for nginx
helm create nginx-chart

# Examine the auto-generated structure
tree nginx-chart

# Modify values.yaml
cat > nginx-chart/values.yaml << 'EOF'
replicaCount: 2
image:
  repository: nginx
  tag: alpine
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 80
ingress:
  enabled: true
  hosts:
    - host: nginx.local
      paths:
        - path: /
          pathType: Prefix
EOF

# Install the chart
helm install nginx-release ./nginx-chart

# Verify
kubectl get deployments,services,ingress

# Scale up
helm upgrade nginx-release ./nginx-chart --set replicaCount=4
kubectl get pods

# Rollback
helm rollback nginx-release 1
kubectl get pods

# Clean up
helm uninstall nginx-release
rm -rf nginx-chart
```

**Expected Outcome:** A complete chart lifecycle: create, deploy, upgrade, rollback, uninstall.

---

### Task 5: Package and Manage Charts

```bash
# Package the server chart
cd helm-charts/server
helm package . -d ../../packaged/

# Verify the package
ls -la ../../packaged/
tar -tzf ../../packaged/server-0.1.0.tgz

# Install from the package
helm install server-release ../../packaged/server-0.1.0.tgz

# List all releases
helm list

# Upgrade with package
helm upgrade server-release ../../packaged/server-0.1.0.tgz --set image.tag=latest

# Rollback
helm rollback server-release 1

# Uninstall
helm uninstall server-release
rm -rf ../../packaged/
```

**Expected Outcome:** Charts can be packaged, shared, installed from `.tgz`, and managed as releases.

---

### Task 6: Create a Parent Chart with Dependencies

```bash
# Navigate to the lab directory
cd ../..

# Create a parent chart that depends on subcharts
mkdir -p monitoring-stack/templates

# Create Chart.yaml with dependencies
cat > monitoring-stack/Chart.yaml << 'EOF'
apiVersion: v2
name: monitoring-stack
description: A complete monitoring stack with Grafana, Loki, Prometheus
version: 0.1.0
dependencies:
  - name: grafana
    version: 0.1.0
    repository: file://../helm-charts/grafana
  - name: prometheus
    version: 0.1.0
    repository: file://../helm-charts/prometheus
  - name: loki
    version: 0.1.0
    repository: file://../helm-charts/loki
EOF

# Update dependencies
cd monitoring-stack
helm dependency update

# Verify the downloaded charts
ls -la charts/

# Install the full monitoring stack
helm install monitoring-release .

# Verify all resources
kubectl get all

# Clean up
helm uninstall monitoring-release
cd ..
rm -rf monitoring-stack
```

**Expected Outcome:** A parent chart composes multiple subcharts into a cohesive application stack.

---

### Task 7: Docker Compose to Helm Conversion

Convert a simple compose file to a Helm chart manually.

```yaml
# docker-compose.yml (simple web + redis)
version: "3.8"
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    environment:
      - NGINX_HOST=localhost
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    restart: always
```

```bash
# 1. Create the chart
helm create web-app

# 2. Modify values.yaml for both services
cat > web-app/values.yaml << 'EOF'
web:
  image:
    repository: nginx
    tag: alpine
  service:
    port: 80
    targetPort: 80
  env:
    NGINX_HOST: localhost

redis:
  image:
    repository: redis
    tag: 7-alpine
  enabled: true
EOF

# 3. Install
helm install web-app-release ./web-app

# 4. Verify
kubectl get pods

# 5. Clean up
helm uninstall web-app-release
rm -rf web-app
```

**Expected Outcome:** A Docker Compose file is successfully converted into a deployable Helm chart.

---

### Task 8: Use --set with Complex Values

```bash
# Deploy with nested values overrides
helm install server-release ./helm-charts/server \
  --set image.repository=node \
  --set image.tag=20-alpine \
  --set 'env[0].name=NODE_ENV' \
  --set 'env[0].value=production' \
  --set 'env[1].name=LOG_LEVEL' \
  --set 'env[1].value=debug' \
  --set resources.limits.cpu=1 \
  --set resources.limits.memory=512Mi

# Verify
helm get values server-release
helm get manifest server-release | grep -A10 "env:"

# Clean up
helm uninstall server-release
```

**Expected Outcome:** Complex nested values are properly set via `--set` flags.

---

## Verification Checklist

- [ ] I understand Helm chart structure (Chart.yaml, values.yaml, templates/)
- [ ] I can deploy and manage releases with `helm install`, `upgrade`, `rollback`, `uninstall`
- [ ] I can customize deployments via `--set` flags and custom values files
- [ ] I can package charts with `helm package`
- [ ] I can map Docker Compose concepts to Kubernetes resources
- [ ] I can create helper templates with `_helpers.tpl`
- [ ] I can set up liveness and readiness probes
- [ ] I can configure Ingress for external access
- [ ] I can use HorizontalPodAutoscaler for auto-scaling
- [ ] I can compose multiple charts into a parent chart with dependencies

---

## Additional Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Helm Chart Template Guide](https://helm.sh/docs/chart_template_guide/)
- [Docker Compose to Kubernetes Mapping](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)

---

## Cleanup

```bash
# Remove all Helm releases
helm uninstall $(helm list -q) 2>/dev/null

# Remove any packaged charts
rm -rf ./packaged ./web-app ./monitoring-stack
```


