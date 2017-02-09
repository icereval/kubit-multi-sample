## pki

Config file | Description
--- | ---
`ca_key_type.json` | configures CA key algorithm & size
`config.json` | configures certificate expirations & usages
`names.json` | configures certificate subject; generated by `scripts/init.sh`
`pki_key_type.json` | configures admin, apiserver, and etcd key algorithms & sizes

Certificate/key pairs | Description
--- | ---
`admin.pem, admin-key.pem` | client auth, used in `kubeconfig`
`apiserver.pem, apiserver-key.pem` | server auth, used by Kubernetes controllers
`ca.pem, ca-key.pem` | common Certificate Authority
`etcd.pem, etcd-key.pem` | peer auth, used by etcd & Kubernetes nodes