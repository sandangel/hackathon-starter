**Objective**
Create an automated deployment pipeline for a web app using containerization and orchestration tools.
The solution must be portable and adaptable to different environments without manual intervention.

**Project Overview**
Use the hackathon-starter project (https://github.com/sahat/hackathon-starter).
This project is a boilerplate for scalable web apps using Node.js, Express, MongoDB, Passport.js, and React.

**Requirements**
- **Memory**: Must run on a machine with at least 4GB RAM.
- **Tools**: Use Docker, Kubernetes, GitHub Actions, and Terraform.
- **Application**: Use the hackathon-starter repository.

**Assignment Steps**

1. **Environment Setup**
   - Create `config.yaml` for environment variables.
   - Implement `setup.sh` to:
     - Auto-detect the OS and install dependencies.
     - Set up Docker and `kind` for local orchestration.
     - Install CI/CD tools like Terraform and kubectl.

2. **Application Modification / Containerization**
   - Write Dockerfiles for frontend and backend.
     - Use separate targets for each.
     - Use multi-stage builds for optimization.
   - Implement `Github Actions` to:
     - Build Docker images for both services.
     - Push images to a container registry.
     - Use matrix to build 2 docker images at the same time.

   **BONUS**
   - Add a blog post feature to the hackathon-starter.
   - Implement CRUD routes, models, and controllers.
   - Update the frontend for blog management.

3. **Orchestration**
   - Create Kubernetes manifests for deployment.
   - Include Deployment, Service, and Ingress resources.
   - Implement `deploy.sh` to:
     - Apply Kubernetes manifests.
     - Configure ingress for 'example.com'.

4. **CI/CD Pipeline**
   - Set up GitHub Actions for CI/CD.
   - Configure to:
     - Pull latest code and run tests.
     - Build and push Docker images.
     - Show manifest diffs in PR comments.
     - Apply Kubernetes manifests.

5. **Documentation**
   - Provide a README with:
     - Setup instructions.
     - Configuration options.
     - Troubleshooting guide.
     - Security considerations.

**Evaluation Criteria**
1. **Portability**: Works across OS and cloud providers.
2. **Automation**: Minimal manual setup and deployment.
3. **Scalability**: Easily scales horizontally.
4. **Security**: Proper security in CI/CD and deployment.
5. **Code Quality**: Clean, well-documented scripts and configs.
6. **Best Practices**: Follows DevOps best practices.
7. **Functionality**: Fully functional and accessible app.
8. **Documentation**: Clear and comprehensive.

**Tools for Testing**
- Docker
- Kind
- GitHub Actions
- Terraform
- Git

**Bonus Points**
- Implement monitoring and logging.
- Add rollback capabilities.
- Use a package manager for dependencies.
- Use multi-stage builds for Docker images.

