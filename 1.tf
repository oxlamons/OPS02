provider "digitalocean"
{ token = var.do_token }

data "digitalocean_ssh_key" "rebrain_ssh_key" {
  name = "REBRAIN.SSH.PUB.KEY"
}
# Add ssh key
resource "digitalocean_ssh_key" "my_ssh" {
  name = "my_ssh"
  public_key = var.my_ssh_key
}

resource "digitalocean_tag" "devops" {
  name = "devops"
}

resource "digitalocean_tag" "my_email" {
  name = "oxlamons_at_gmail_com"
}
# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "test" {
  image = "ubuntu-18-04-x64"
  name = "test223053"
  region = "fra1"
  size = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.my_ssh.fingerprint, data.digitalocean_ssh_key.rebrain_ssh_key.fingerprint]
  tags = [digitalocean_tag.devops.name, digitalocean_tag.my_email.name] }
   //так и не понял как получить Ip адресс только что созданной машины?
   /* data "digitalocean_droplet" "out_ip" { name = digitalocean_droplet.test.name }
   output "drop_ip" { value = data.digitalocean_droplet.out_ip.ipv4_address } */
