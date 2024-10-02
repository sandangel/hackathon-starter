## Why Gateway API?

This project uses the Kubernetes Gateway API instead of the traditional Ingress for managing external access to services within the cluster. The Gateway API provides a more expressive and extensible way to configure networking in Kubernetes.

The Kubernetes Gateway API is chosen for its advanced capabilities in managing L4 and L7 routing, offering a more expressive and role-oriented approach compared to traditional Ingress. Key reasons include:

1. **Role-oriented Design**: It separates concerns into distinct resources, allowing infrastructure providers, cluster operators, and application developers to manage their respective areas effectively.
2. **Flexibility and Extensibility**: Supports complex routing configurations and allows for custom resources, making it adaptable to various organizational needs.
3. **Standardization and Portability**: As a standard API, it is supported by multiple implementations, ensuring portability across different environments.
4. **Advanced Features**: Provides capabilities like header-based matching, traffic weighting, and more, which were previously only possible through custom annotations in Ingress.
5. **Service Mesh Support**: Through the GAMMA initiative, it supports service mesh use cases, allowing routing resources to be associated directly with services.

For more details, refer to the [Gateway API documentation](https://gateway-api.sigs.k8s.io/).

### Key Components

- **Gateway**: Represents the infrastructure (like a load balancer) that handles traffic.
- **HTTPRoute**: Defines how traffic should be routed to services based on rules.

### Configuration

**Note:** The 443 listener for the Gateway is not configured yet and will be addressed in a future update.

- **Gateway**: Defined in `gateway.yaml`, it specifies the entry point for traffic and the protocols supported.
- **HTTPRoute**: Defined in `httproute.yaml`, it specifies the routing rules and backend services.

## Health Checks, Resource Settings, Auto scaling and Pod Anti-Affinity

The `k8s/base/deployment.yaml` file includes configurations for health checks and resource management to ensure the application runs efficiently and reliably:

- **Liveness and Readiness Probes**:
  - **Liveness Probe**: Ensures the application is running and restarts it if necessary. Configured with an HTTP GET request to the root path, with an initial delay of 30 seconds and a period of 10 seconds.
  - **Readiness Probe**: Checks if the application is ready to handle requests. Configured similarly to the liveness probe but with an initial delay of 5 seconds.

- **Resource Requests and Limits**:
  - **Requests**: Specifies the minimum amount of CPU (250m) and memory (256Mi) resources required for the application to run.
  - **Limits**: Defines the maximum amount of CPU (500m) and memory (512Mi) resources the application can use, preventing resource overconsumption.

- **Pod Anti-Affinity**:
  - Ensures that pods are spread across different nodes to improve availability and fault tolerance. Configured using `podAntiAffinity` with a `requiredDuringSchedulingIgnoredDuringExecution` rule to prevent scheduling on the same node.

- **Horizontal Pod Autoscaling**:
  - Automatically adjusts the number of pod replicas based on CPU utilization. Configured to maintain an average CPU utilization of 50%, scaling between 2 and 10 replicas as needed.

These settings help maintain application stability and performance by ensuring proper resource allocation, monitoring application health, enhancing fault tolerance, and dynamically adjusting resources based on demand.

## Security Policies

The `k8s/base/deployment.yaml` file includes several security policies to enhance the security posture of the application:

- **Non-Root User**: The container is configured to run as a non-root user (`runAsNonRoot: true`) with a specific user and group ID (`runAsUser: 1000`, `runAsGroup: 1000`), reducing the risk of privilege escalation.
- **Read-Only Filesystem**: The filesystem is set to read-only (`readOnlyRootFilesystem: true`), preventing unauthorized modifications to the container's filesystem.
- **Dropped Capabilities**: All Linux capabilities are dropped (`capabilities: drop: - ALL`), minimizing the potential attack surface.
- **No Privilege Escalation**: The container is not allowed to gain additional privileges (`allowPrivilegeEscalation: false`), further securing the environment.

These settings are crucial for maintaining a secure Kubernetes deployment by adhering to the principle of least privilege.

