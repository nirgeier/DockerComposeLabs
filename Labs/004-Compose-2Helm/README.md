<!-- omit in toc -->
# How to Create and Use a Helm Chart

- Helm is a powerful package manager for Kubernetes that simplifies the deployment and management of applications.
- This lab will walk you through the process of creating and using a Helm chart.

---

<!-- omit in toc -->
## Prerequisites

Before you begin, ensure you have the following installed:

1. **Kubernetes Cluster**: A running Kubernetes cluster.
2. **Helm**: Installed and configured. You can install Helm by following the [official Helm installation guide](https://helm.sh/docs/intro/install/).
3. **kubectl**: Installed and configured to interact with your Kubernetes cluster.

---

<!-- omit in toc -->
## Table of Contents

- [Step 1: Create a New Helm Chart](#step-1-create-a-new-helm-chart)
- [Step 2: Customize the Chart](#step-2-customize-the-chart)
- [Step 3: Package the Chart](#step-3-package-the-chart)
- [Step 4: Deploy the Chart](#step-4-deploy-the-chart)
- [Step 5: Upgrade and Manage the Chart](#step-5-upgrade-and-manage-the-chart)
- [Step 6: Pass Values to the Helm Chart](#step-6-pass-values-to-the-helm-chart)

---

## Step 1: Create a New Helm Chart

1. Navigate to the directory where you want to create the Helm chart:

   ```bash
   cd /path/to/your/directory
   ```

2. Use the `helm create` command to scaffold a new Helm chart:

   ```bash
   helm create my-chart
   ```

   This will create a directory structure for your chart, including default templates and configuration files.

---

## Step 2: Customize the Chart

1. **Edit `values.yaml`:**
   - Open the `values.yaml` file in the chart directory.
   - Define the default values for your application, such as image repository, tag, and resource limits.

2. **Modify Templates:**
   - Navigate to the `templates/` directory.
   - Edit the YAML files (e.g., `deployment.yaml`, `service.yaml`) to define Kubernetes resources for your application.

3. **Add Configurations:**
   - If your application requires additional configurations, add them to the `templates/` directory or include them in `values.yaml`.

---

## Step 3: Package the Chart

1. Package the chart into a `.tgz` file:

   ```bash
   helm package my-chart
   ```

   This creates a compressed file that can be shared or uploaded to a Helm repository.

2. Optionally, you can upload the packaged chart to a Helm repository for distribution.

---

## Step 4: Deploy the Chart

1. Install the chart in your Kubernetes cluster:

   ```bash
   helm install my-release ./my-chart
   ```

   Replace `my-release` with a name for your release and `./my-chart` with the path to your chart.

2. Verify the deployment:

   ```bash
   kubectl get all
   ```

   Ensure all resources are created and running as expected.

---

## Step 5: Upgrade and Manage the Chart

1. **Upgrade the Release:**
   - Modify the chart or `values.yaml` as needed.
   - Apply the changes:

     ```bash
     helm upgrade my-release ./my-chart
     ```

2. **Rollback Changes:**
   - If something goes wrong, rollback to a previous version:

     ```bash
     helm rollback my-release 1
     ```

     Replace `1` with the desired revision number.

3. **Uninstall the Release:**
   - To remove the release and its resources:

     ```bash
     helm uninstall my-release
     ```

---

## Step 6: Pass Values to the Helm Chart

Helm allows you to override default values defined in the `values.yaml` file by passing custom values during installation or upgrade. This is useful for customizing deployments without modifying the chart itself.

1. **Pass Values via Command Line:**
   - Use the `--set` flag to specify values directly in the command:

     ```bash
     helm install my-release ./my-chart --set key1=value1,key2=value2
     ```

     Example:

     ```bash
     helm install my-release ./my-chart --set image.tag=1.2.3,replicaCount=3
     ```

2. **Use a Custom Values File:**
   - Create a custom YAML file (e.g., `custom-values.yaml`) with the values you want to override:

     ```yaml
     replicaCount: 3
     image:
       tag: 1.2.3
     ```

   - Pass the file using the `-f` flag:

     ```bash
     helm install my-release ./my-chart -f custom-values.yaml
     ```

3. **Combine Multiple Methods:**
   - You can combine the `--set` flag and custom values file. The `--set` values take precedence over the file:

     ```bash
     helm install my-release ./my-chart -f custom-values.yaml --set replicaCount=5
     ```

- This allows you to customize your Helm chart deployments flexibly, adapting to different environments or requirements without modifying the chart itself.
