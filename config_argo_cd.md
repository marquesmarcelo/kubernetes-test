## ArgoCD Application (exemplo para homologacao)
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: meu-app-hml
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/nome-usuario/meu-app.git'
    targetRevision: homologacao
    path: charts/app
    helm:
      valueFiles:
        - ../../environments/hml/values.yaml
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: meu-app
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
