# remote-vpn

Runs a **WireGuard server** on the provisioned Linux host so devices at home (behind your UniFi Max Gateway) can connect to this machine over the public internet.

Disabled by default (`configure_remote_vpn: false`).

## Enable

In `config.yml`:

```yaml
configure_remote_vpn: true
remote_vpn_public_endpoint: "203.0.113.10"  # public IP or DNS of this host
remote_vpn_peers:
  - name: home-laptop
    address: 10.200.0.2/32
```

Re-run: `ansible-playbook main.yml -i inventory -K --tags remote-vpn`

Client configs are written under `~/wireguard-clients/<name>.conf` — import into the WireGuard app on your laptop or phone at home.

Open UDP `remote_vpn_listen_port` (default `51820`) in your cloud firewall and any host firewall.

UniFi Teleport is not configured here; add that separately when ready.
