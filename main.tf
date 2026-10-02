# Los módulos se deben declarar con todas las variables obligatorias

module "network" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    availability_zone_1 = var.availability_zone_1
    availability_zone_2 = var.availability_zone_2
    public_subnet_1 = var.subnet_1_cidr
    public_subnet_2 = var.subnet_2_cidr
    private_subnet_1 = var.subnet_3_cidr
    private_subnet_2 = var.subnet_4_cidr
    private_subnet_3 = var.subnet_5_cidr
    private_subnet_4 = var.subnet_6_cidr
}

module "security" {
    source = "./modules/security"
    vpc_id = module.network.vpc_id
}

module "compute" {
    source = "./modules/compute"
    master_type = var.master_type
    public_subnet_id = module.network.public_subnet_1_id
    security_group_id = module.security.security_group_id
    key_name = var.key_name
    root_volume_size = var.root_volume_size
    root_volume_type = var.root_volume_type
}

module "load_balancer" {
    source = "./modules/load_balancer"
    security_group_ids = [module.security.security_group_id]
    subnet_ids = [module.network.public_subnet_1_id, module.network.public_subnet_2_id]
    vpc_id = module.network.vpc_id
    worker_instance_id = module.compute.worker_instance_id
}