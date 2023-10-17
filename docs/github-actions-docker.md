Creating Docker images and pushing them to Docker Hub using GitHub Actions is a common CI/CD practice that can help automate the workflow of building and deploying Docker containers. Below is a step-by-step guide to achieving this:

1. **Create a Docker Hub Account and Repository**:

   - Before you begin, make sure you have a Docker Hub account and a repository where you will push your Docker images.

2. **Setup GitHub Repository**:

   - Create a GitHub repository where your project's code resides.

3. **Create a Dockerfile**:

   - In your project repository, create a `Dockerfile` that contains the instructions to build your Docker image.

4. **Setup GitHub Secrets**:

   - In your GitHub repository, navigate to `Settings` -> `Secrets`.
   - Add two new secrets: `DOCKER_USERNAME` and `DOCKER_PASSWORD` with your Docker Hub credentials.

5. **Create a GitHub Actions Workflow**:

   - In your repository, create a directory called `.github` and within it another directory called `workflows`.
   - Create a new file, e.g., `docker-image.yml` inside the `workflows` directory.

6. **Configure the Workflow**:

   ```yaml
   name: Build and Push Docker image

   on:
     push:
       branches:
         - main

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
         - name: Checkout code
           uses: actions/checkout@v2

         - name: Set up Docker Buildx
           uses: docker/setup-buildx-action@v1

         - name: Login to DockerHub
           uses: docker/login-action@v1
           with:
             username: ${{ secrets.DOCKER_USERNAME }}
             password: ${{ secrets.DOCKER_PASSWORD }}

         - name: Build and push Docker image
           uses: docker/build-push-action@v2
           with:
             context: .
             push: true
             tags: docker.io/${{ secrets.DOCKER_USERNAME }}/your-repo-name:latest
   ```

7. **Push Changes**:

   - Commit and push the changes to your repository. This will trigger the GitHub Actions workflow, build the Docker image, and push it to Docker Hub.

8. **Verify the Workflow**:
   - Check the "Actions" tab in your GitHub repository to see the workflow run.
   - Once the workflow completes, check your Docker Hub repository to see the new image pushed.

This workflow is quite basic and serves the purpose of demonstrating how to build a Docker image and push it to Docker Hub using GitHub Actions. You can further customize the workflow by adding more steps, such as running tests, scanning the image for vulnerabilities, or deploying the image to a Kubernetes cluster.
