# Lista de comandos úteis do Kubernetes

Forma de acesso ao Argo CD para fins de teste via port-forward:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

1. Parar o container do cluster Kind

Quando você executa o comando kind create cluster, o Kind cria um container Docker para hospedar o cluster Kubernetes. Para parar o container, você pode simplesmente usar o comando:

```bash
docker ps # Para encontrar o ID do container do seu cluster Kind

docker stop <container-id>
```

2. Iniciar o container do cluster Kind

Para iniciar novamente o cluster, você pode usar o comando:

```bash
docker ps -a # Para encontrar o ID do container do seu cluster Kind

docker start <container-id>
```

ou, se tiver registrado com o nome kind-dev

```bash
docker start kind-kdev
```

3. Verificar se o cluster foi retomado

Depois de reiniciar o container, o seu cluster Kubernetes ainda estará lá. Você pode verificar com:

```bash
kubectl get pods --all-namespaces
```

Lista de comandos básicos:

```bash
kubectl get nodes                 # Lista os nós do cluster
kubectl get pods -n <ns>         # Lista pods do namespace
kubectl get all -n <ns>          # Tudo (pods, svc, deploys, etc.)
kubectl get deploy -n <ns>       # Lista deployments
kubectl get svc -n <ns>          # Lista services
kubectl get ingress -n <ns>      # Lista ingress
kubectl describe pod <pod> -n <ns>  # Detalha pod
kubectl get events -n <ns>       # Mostra eventos (erros, etc.)
```

Lista de comandos para gerenciamento de PODs

```bash
kubectl apply -f arquivo.yaml              # Aplica uma config
kubectl apply -k pasta/                    # Aplica via Kustomize
kubectl rollout restart deploy <nome> -n <ns>  # Reinicia um deployment (puxa nova imagem)
kubectl delete pod <pod> -n <ns>           # Deleta pod (será recriado se for de deployment)
kubectl exec -it <pod> -n <ns> -- bash     # Acessa terminal dentro do pod
kubectl logs <pod> -n <ns>                 # Ver logs
kubectl logs -f <pod> -n <ns>              # Ver logs em tempo real
kubectl top pod -n <ns>                    # Ver consumo de CPU e memória (se metrics-server estiver instalado)
```

Lista de comandos de teste/debug

```bash
kubectl port-forward svc/<svc-name> 8080:80 -n <ns>  # Redireciona porta local pra service (teste local)
kubectl exec -it <pod> -n <ns> -- curl http://localhost:80   # Testa chamada interna
kubectl get endpoints -n <ns>                       # Verifica se os serviços têm pods atrelados
```

Lista de comandos sobre imagens/deploy

```bash
kubectl set image deploy/<deploy> <container>=usuario/imagem:nova -n <ns>  # Atualiza imagem
kubectl patch deployment <deploy> -n <ns> -p '{"spec":{"template":{"metadata":{"annotations":{"date":"'"$(date +%s)"'"}}}}}'
# Força redeploy sem mudar imagem (via annotation)
```

Comandos adicionais

```bash
kubectl config get-contexts         # Ver contextos configurados
kubectl config current-context      # Ver contexto atual
kubectl config use-context kind-kdev  # Troca de contexto
kubectl cluster-info                # Info do cluster
kubectl api-resources               # Ver recursos disponíveis (Ingress, CRDs, etc)
```

Comandos de limpeza/gerenciamento

```bash
kubectl delete -f arquivo.yaml            # Remove recurso
kubectl delete all --all -n <ns>          # Apaga tudo de um namespace (cuidado!)
kubectl delete ns <ns>                    # Deleta namespace
```

Comandos para TROUBLESHOOTING INGRESS

```bash
kubectl get ingress -n <ns>
kubectl describe ingress <ingress> -n <ns>
kubectl get svc -n ingress-nginx
kubectl get pods -n ingress-nginx
kubectl logs -n ingress-nginx <pod>       # Ver logs do Ingress NGINX
```

Comandos sobre o Kustomize

```bash
kubectl kustomize pasta/                  # Mostra o YAML gerado pelo Kustomize (sem aplicar)
```

Testes com o curl no Kubernetes

```bash
curl http://app1.kdev.local                  # Testa se o host resolve e está servindo
curl -H "Host: app1.kdev.local" http://localhost  # Força header `Host` (caso sem DNS configurado)
```

Testar dentro do cluster (via kubectl exec)

```bash
kubectl exec -it <pod> -n <ns> -- curl http://<serviço>:<porta>
kubectl exec -it <pod> -n <ns> -- curl http://app1.dev.svc.cluster.local:80
```

Testar conectividade com parâmetros

```bash
curl -v http://app1.kdev.local            # Verbose (ver cabeçalhos, DNS, etc.)
curl -I http://app1.kdev.local            # Apenas cabeçalhos da resposta
curl -X POST -d '{"foo":"bar"}' http://app1.kdev.local -H "Content-Type: application/json"
```

Testar com tempo limite e debug

```bash
curl -m 5 http://app1.kdev.local          # Timeout de 5 segundos
curl -L http://app1.kdev.local            # Segue redirects
curl --resolve app1.kdev.local:80:127.0.0.1 http://app1.kdev.local  # Força IP no DNS
```

Verificar resposta específica
```bash
curl -s -o /dev/null -w "%{http_code}\n" http://app1.kdev.local
```

Teste com cabeçalhos personalizados

```bash
curl -H "X-Debug: true" http://app1.kdev.local
curl -H "Authorization: Bearer <token>" http://app1.kdev.local
```

Com jq pra tratar JSON de API

```bash
curl -s http://app1.kdev.local/api/status | jq .
```