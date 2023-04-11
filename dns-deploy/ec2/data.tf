data "consul_keys" "dns" {
    key {
        name = "number"
        path = "${var.PROJECT_NAME}/ec2/dns/number"
    }
    key {
        name = "instance_type" 
        path = "${var.PROJECT_NAME}/ec2/dns/instance_type"
    }
    key { 
        name = "ami" 
        path = "${var.PROJECT_NAME}/ec2/dns/ami"
    }
    key { 
        name = "public_ip" 
        path = "${var.PROJECT_NAME}/ec2/dns/public_ip"
    }
}

data "consul_keys" "webservers" {
    key {
        name = "number"
        path = "${var.PROJECT_NAME}/ec2/webservers/number"
    }
    key {
        name = "instance_type" 
        path = "${var.PROJECT_NAME}/ec2/webservers/instance_type"
    }
    key { 
        name = "ami" 
        path = "${var.PROJECT_NAME}/ec2/webservers/ami"
    }
    key { 
        name = "public_ip" 
        path = "${var.PROJECT_NAME}/ec2/webservers/public_ip"
    }
}

data "consul_keys" "users" {
    key {
        name = "number"
        path = "${var.PROJECT_NAME}/ec2/users/number"
    }
    key {
        name = "instance_type" 
        path = "${var.PROJECT_NAME}/ec2/users/instance_type"
    }
    key { 
        name = "ami" 
        path = "${var.PROJECT_NAME}/ec2/users/ami"
    }
    key { 
        name = "public_ip" 
        path = "${var.PROJECT_NAME}/ec2/users/public_ip"
    }
}

data "consul_keys" "network" {
    key {
        name = "subnet_id"
        path = "${var.PROJECT_NAME}/network/subnet/id"
    }
}

data "consul_keys" "ssh_key" {
    key {
        name = "id"
        path = "${var.PROJECT_NAME}/ssh_keys/common/id"
    }
}

data "consul_keys" "security_groups" {
    key {
        name = "ssh_from_internet_id"
        path = "${var.PROJECT_NAME}/security_groups/ssh_from_internet/id"
    }
    key {
        name = "ping_id"
        path = "${var.PROJECT_NAME}/security_groups/ping/id"
    }
}

