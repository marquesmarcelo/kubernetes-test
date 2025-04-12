Para verificar o conteúdo do Secret gerado:

```bash
kubectl get secret argocd-ldap-secret -n argocd
```

Ver o conteúdo do Secret (decodificado para base64):

```bash
kubectl get secret argocd-ldap-secret -n argocd -o yaml
```

A senha estará codificada em base64. Para decodificar, você pode usar o seguinte comando:

```bash
kubectl get secret argocd-ldap-secret -n argocd -o jsonpath="{.data.ldap\.bindPW}" | base64 --decode
```
