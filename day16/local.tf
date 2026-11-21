locals {
  users=csvdecode(file("user.csv"))
}

