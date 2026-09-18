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