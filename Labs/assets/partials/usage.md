<!-- markdownlint-disable MD033 -->

## Usage

- There are several ways to run the DockerComposeLabs Labs.
- Choose the method that works best for you.

=== "🐳 Docker (Recommended)"

    Using Docker is the easiest way to get started locally with the labs:

    ```bash
    # GitHub Container Registry
    docker run -it --pull=always -p 3000:3000 ghcr.io/nirgeier/dockercomposelabs
    ```

    **Prerequisites:**

    - Docker and Docker Compose installed on your system
    - No additional setup required

=== "![](assets/images/killercoda-icon.png){:. width-24px} Killercoda"

    * The easiest way to get started with the labs
    * Learn in your browser without any local installation

    🌐 <a href="https://killercoda.com/codewizard/scenario/DockerComposeLabs" target="_blank">**Launch on Killercoda**</a>

      **Benefits:**

      - No installation required
      - Pre-configured environment
      - Works on any device with a web browser
      - All tools pre-installed

=== "📜 From Source"

    For those who prefer to run it directly on their machine:

    ```bash
    # Clone the repository
    git clone https://github.com/nirgeier/DockerComposeLabs
    # Change to the Labs directory
    cd DockerComposeLabs/Labs
    # Start with the setup lab
    cd .includes
    # Follow the instructions in the README of each lab
    cat README.md
    ```

    **Prerequisites:**

    - A Unix-like operating system (Linux, macOS, or Windows with WSL)
    - Basic command-line tools

=== "![](assets/images/gcp.png){:.width-24px} Using Google Cloud Shell"

    - Google Cloud Shell provides a free, browser-based environment with all necessary tools pre-installed.
    - Click on the `Open in Google Cloud Shell` button below:

      [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

    - The repository will automatically be cloned into a free Cloud instance.
    - Use **<kbd>CTRL</kbd>** + click to open it in a new window.
    - Follow the instructions in the README of each lab.

    **Benefits:**

    - No local installation required
    - Pre-configured environment
    - Works on any device with a web browser
    - All tools pre-installed
    - Free tier available

<!-- markdownlint-enable MD033 -->