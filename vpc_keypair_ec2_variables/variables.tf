variable cidr_block {
default = "192.168.0.0/16"
}
variable tag {
default = "prod"
}
variable subnet1_cidr_block {
default = "192.168.0.0/24"
}
variable availability_zone {
default = "ap-south-1b"
}
variable subnet2_cidr_block {
default = "192.168.2.0/24"
}


variable ami-id {
default = "ami-08df646e18b182346"
}

variable keypair {
default = "dev"
}

variable instance_type {
default = "t2.micro"
}
