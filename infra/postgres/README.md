# Acesso interno

Os pods dentro do cluster acessam normalmente com:

```bash
Host: postgres.shared.svc.cluster.local
Porta: 5432
```

# Acesso externo (via host)

No computador (host do Kind) é possível acessar:


```bash
psql -h 127.0.0.1 -p 30032 -U admin
```