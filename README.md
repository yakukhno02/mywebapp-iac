# Lab 4 — IaC with Terraform and Ansible

## Architecture

The system consists of two virtual machines:

### worker VM
- nginx
- Spring Boot application

### db VM
- PostgreSQL

```text
client → nginx → web application → PostgreSQL
```

---

# Terraform

## Initialize Terraform

```bash
cd terraform
terraform init
```

## Create infrastructure

```bash
terraform apply
```

After deployment check VMs:

```bash
multipass list
```

---

# Ansible

## Update inventory

Edit:

```text
ansible/inventory.ini
```

Example:

```ini
[workers]
worker-tf ansible_host=192.168.x.x ansible_user=ubuntu

[db]
db-tf ansible_host=192.168.x.x ansible_user=ubuntu
```

---

## Run playbook

```bash
cd ansible
ansible-playbook -i inventory.ini site.yml
```

---

# Verification

## Check application

```bash
curl http://WORKER_IP:8080/items
```

---

## Health checks

```bash
curl http://WORKER_IP:8080/health/alive
```

```bash
curl http://WORKER_IP:8080/health/ready
```

---

## Verify teacher access

```bash
ssh teacher@WORKER_IP
```

Password:

```text
12345678
```

Check sudo:

```bash
sudo apt update
```

---

## Verify operator access

```bash
ssh operator@WORKER_IP
```

Password:

```text
12345678
```

Allowed:

```bash
sudo docker ps
```

Denied:

```bash
sudo apt update
```

---

## Verify idempotency

Run playbook again:

```bash
ansible-playbook -i inventory.ini site.yml
```

Verify there are no duplicate records:

```bash
curl http://WORKER_IP:8080/items
```

---


# Gradebook

Variant number is stored in:

```text
/home/student/gradebook
```

Check:

```bash
ssh -i ~/.ssh/multipass_id_rsa ubuntu@WORKER_IP "cat /home/student/gradebook"
```

---

# Repository Structure

```text
terraform/   -> infrastructure provisioning
ansible/     -> configuration management
app/         -> Spring Boot application
```
