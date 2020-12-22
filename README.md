# Kubernetes tools - k8s-tools

A small image with useful Kubernetes tools that I use on daily basis.

It can be used with [kubernetes-plugin](https://github.com/jenkinsci/kubernetes-plugin) on Jenkins in case you run agents on Kubernetes. Here is the Jenkinsfile example:

```
def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'k8s-tools', image: 'njegosrailic/k8s-tools:0.1.0', command: 'cat', ttyEnabled: true),
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
    stage('Run kubectl') {
      container('k8s-tools') {
        sh "kubectl version --client"
      }
    }
    stage('Run helm') {
      container('k8s-tools') {
        sh "helm version"
      }
    }
  }
}
```
