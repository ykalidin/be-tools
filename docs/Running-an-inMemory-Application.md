# Running an inMemory Application

* For this deployment, the sample YAML files are available at BE_HOME->cloud->kubernetes->cloud_name->inmemory

* Your TIBCO BusinessEvents application Docker image must be uploaded to respective cloud Container Registry.

1.  Create the Kubernetes object specification \(`.yaml`\) files based on your deployment requirement.

    For details about describing Kubernetes objects in a YAML file, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/).

    ```
    kubectl create -f beinferenceagent.yaml

    kubectl create -f befdservice.yaml
    ```

2.  Get the external IP of your application which you can then use to connect to the cluster.

    **Syntax**:

    ```
    kubectl get services <external_service_name>
    ```

    For example,

    ```
    kubectl get services befdservice
    ```

## Testing

* See [Testing](Testing.md)

**Parent topic:** [Running an Application](Running%20an%20Application)
