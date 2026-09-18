
# Configure VPC
resource "aws_vpc" "VPCARQUITECTURA" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_hostnames = true #Asigna un nombre DNS a las instancias lanzadas en la VPC
    enable_dns_support = true #Permite resolución de nombres DNS para instancias en la VPC
    tags = {
        Name = "vpc-arquitectura-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
}

#Configure Subnets

#Las subnets las puedo crear iterando sobre el bloque con el count
# esto se puede hacer usando el parámetro count y una lista de subnets y availability zones.
# Por ejemplo:

# resource "aws_subnet" "SBN_ARQUITECTURA_001" {
#     count = 2 # Por ejemplo, si quiero crear dos subnets públicas
#     vpc_id = aws_vpc.VPCARQUITECTURA.id
#     cidr_block = var.public_subnets[count.index]
#     availability_zone = var.availability_zones[count.index]
#     map_public_ip_on_launch = true #Subnet publica
#     tags = {
#         Name = "sbn-arq-front-${terraform.workspace}-${count.index + 1}"
#         Environment = "${terraform.workspace}"
#         Owner = "devgalop"
#     }
#     depends_on = [ 
#         aws_vpc.VPCARQUITECTURA 
#     ]
# }

# Para efectos de practica, se crea cada una de las subnets de manera individual en lugar de usar count.
resource "aws_subnet" "SBN_ARQUITECTURA_001" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.public_subnet_1}"
    availability_zone = "${var.availability_zone_1}"
    map_public_ip_on_launch = true #Subnet publica
    tags = {
        Name = "sbn-arq-front-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_subnet" "SBN_ARQUITECTURA_002" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.public_subnet_2}"
    availability_zone = "${var.availability_zone_2}"
    map_public_ip_on_launch = true #Subnet publica
    tags = {
        Name = "sbn-arq-front-${terraform.workspace}-002"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_subnet" "SBN_ARQUITECTURA_003" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.private_subnet_1}"
    availability_zone = "${var.availability_zone_1}"
    map_public_ip_on_launch = false #Subnet privada
    tags = {
        Name = "sbn-arq-back-${terraform.workspace}-003"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_subnet" "SBN_ARQUITECTURA_004" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.private_subnet_2}"
    availability_zone = "${var.availability_zone_2}"
    map_public_ip_on_launch = false #Subnet privada
    tags = {
        Name = "sbn-arq-back-${terraform.workspace}-004"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_subnet" "SBN_ARQUITECTURA_005" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.private_subnet_3}"
    availability_zone = "${var.availability_zone_1}"
    map_public_ip_on_launch = false #Subnet privada
    tags = {
        Name = "sbn-arq-persistence-${terraform.workspace}-005"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_subnet" "SBN_ARQUITECTURA_006" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    cidr_block = "${var.private_subnet_4}"
    availability_zone = "${var.availability_zone_2}"
    map_public_ip_on_launch = false #Subnet privada
    tags = {
        Name = "sbn-arq-persistence-${terraform.workspace}-006"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

resource "aws_internet_gateway" "IGW_ARQUITECTURA_001" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    tags = {
        Name = "igw-arq-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA 
    ]
}

# Elastic IP for NAT Gateway
resource "aws_eip" "EIP_ARQUITECTURA_001" {
    domain = "vpc"
    
    tags = {
        Name = "nat-arq-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_internet_gateway.IGW_ARQUITECTURA_001 #Depende del Internet Gateway para salir a internet
    ]
}

# Si utilizo iteraciones, para asignar el id debo usar el índice del count, por ejemplo: aws_subnet.SBN_ARQUITECTURA[count.index].id
# por ejemplo, si quiero asociar la segunda subred pública, usaría aws_subnet.SBN_ARQUITECTURA[count.index + 1].id

resource "aws_nat_gateway" "NAT_ARQUITECTURA_001" {
    allocation_id = aws_eip.EIP_ARQUITECTURA_001.id
    subnet_id = aws_subnet.SBN_ARQUITECTURA_001.id # Se asocia a la subred pública 001
    connectivity_type = "public"
    tags = {
        Name = "nat-arq-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_eip.EIP_ARQUITECTURA_001,
        aws_internet_gateway.IGW_ARQUITECTURA_001,
        aws_subnet.SBN_ARQUITECTURA_001
    ]
}

resource "aws_route_table" "RT_ARQUITECTURA_Public_001" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW_ARQUITECTURA_001.id
    }
    tags = {
        Name = "rt-arq-public-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA,
        aws_internet_gateway.IGW_ARQUITECTURA_001
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Public_001" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_001.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Public_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Public_001,
        aws_subnet.SBN_ARQUITECTURA_001
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Public_002" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_002.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Public_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Public_001,
        aws_subnet.SBN_ARQUITECTURA_002
    ]
}

resource "aws_route_table" "RT_ARQUITECTURA_Private_001" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT_ARQUITECTURA_001.id
    }
    tags = {
        Name = "rt-arq-private-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [ 
        aws_vpc.VPCARQUITECTURA,
        aws_nat_gateway.NAT_ARQUITECTURA_001
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Private_001" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_003.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Private_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Private_001,
        aws_subnet.SBN_ARQUITECTURA_003
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Private_002" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_004.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Private_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Private_001,
        aws_subnet.SBN_ARQUITECTURA_004
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Private_003" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_005.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Private_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Private_001,
        aws_subnet.SBN_ARQUITECTURA_005
    ]
}

resource "aws_route_table_association" "RTA_ARQUITECTURA_Private_004" {
    subnet_id = aws_subnet.SBN_ARQUITECTURA_006.id
    route_table_id = aws_route_table.RT_ARQUITECTURA_Private_001.id
    depends_on = [
        aws_route_table.RT_ARQUITECTURA_Private_001,
        aws_subnet.SBN_ARQUITECTURA_006
    ]
}

# Si uso iteraciones para asignar los ids, puedo utilizar el caracter *
# Por ejemplo, si quiero asociar todas las subnets a una ACL de red, puedo hacer:
# subnet_ids = concat[aws_subnet.SBN_ARQUITECTURA_[*].id]


# Puedo asociar las reglas en un mismo acl con ingress y egress, definiendo múltiples bloques de aws_network_acl_rule para el mismo aws_network_acl.
# resource "aws_network_acl" "NACL_ARQUITECTURA_001" {
#     vpc_id = aws_vpc.VPCARQUITECTURA.id
#     subnet_ids = [aws_subnet.SBN_ARQUITECTURA_001.id, aws_subnet.SBN_ARQUITECTURA_002.id, aws_subnet.SBN_ARQUITECTURA_003.id, aws_subnet.SBN_ARQUITECTURA_004.id, aws_subnet.SBN_ARQUITECTURA_005.id, aws_subnet.SBN_ARQUITECTURA_006.id]
#     ingress { # Hace referencia a las reglas de entrada
#         protocol = "tcp"
#         rule_action = "allow"
#         cidr_block = "0.0.0.0/0"
#         from_port = 0
#         to_port = 65535
#     }
#     egress { # Hace referencia a las reglas de salida
#         protocol = "tcp"
#         rule_action = "allow"
#         cidr_block = "0.0.0.0/0"
#         from_port = 0
#         to_port = 65535
#     }
#     tags = {
#         Name = "nacl-arq-${terraform.workspace}-001"
#         Environment = "${terraform.workspace}"
#         Owner = "devgalop"
#     }
#     depends_on = [
#         aws_vpc.VPCARQUITECTURA
#     ]
# }


resource "aws_network_acl" "NACL_ARQUITECTURA_001" {
    vpc_id = aws_vpc.VPCARQUITECTURA.id
    subnet_ids = [aws_subnet.SBN_ARQUITECTURA_001.id, aws_subnet.SBN_ARQUITECTURA_002.id, aws_subnet.SBN_ARQUITECTURA_003.id, aws_subnet.SBN_ARQUITECTURA_004.id, aws_subnet.SBN_ARQUITECTURA_005.id, aws_subnet.SBN_ARQUITECTURA_006.id]
    tags = {
        Name = "nacl-arq-${terraform.workspace}-001"
        Environment = "${terraform.workspace}"
        Owner = "devgalop"
    }
    depends_on = [
        aws_vpc.VPCARQUITECTURA
    ]
}

resource "aws_network_acl_rule" "NACL_ARQUITECTURA_001_INBOUND" {
    network_acl_id = aws_network_acl.NACL_ARQUITECTURA_001.id
    rule_number = 100
    egress = false #Identificar si es de entrada o salida (False = entrada, True = salida)
    protocol = "tcp" #Puede ser valor decimal o nombre del protocolo (tcp, udp, icmp) -1 para todos los protocolos
    rule_action = "allow" # Accion de la regla (allow = permitir, deny = denegar)
    cidr_block = "0.0.0.0/0" # Rango de direcciones IP al que se aplica la regla
    from_port = 0
    to_port = 65535
    depends_on = [
        aws_network_acl.NACL_ARQUITECTURA_001
    ]
}

resource "aws_network_acl_rule" "NACL_ARQUITECTURA_001_OUTBOUND" {
    network_acl_id = aws_network_acl.NACL_ARQUITECTURA_001.id
    rule_number = 100
    egress = true #Identificar si es de entrada o salida (False = entrada, True = salida)
    protocol = "tcp" #Puede ser valor decimal o nombre del protocolo (tcp, udp, icmp) -1 para todos los protocolos
    rule_action = "allow" # Accion de la regla (allow = permitir, deny = denegar)
    cidr_block = "0.0.0.0/0" # Rango de direcciones IP al que se aplica la regla
    from_port = 0 #Opcional cuando se especifica -1 para todos los puertos
    to_port = 65535 #Opcional cuando se especifica -1 para todos los puertos
    depends_on = [
        aws_network_acl.NACL_ARQUITECTURA_001
    ]
}

# Para validar por consola utilizo output
output "vpc_id" {
    value = aws_vpc.VPCARQUITECTURA.id
}
output "public_subnet_1_id" {
    value = aws_subnet.SBN_ARQUITECTURA_001.id
}
output "public_subnet_2_id" {
    value = aws_subnet.SBN_ARQUITECTURA_002.id
}
output "private_subnet_1_id" {
    value = aws_subnet.SBN_ARQUITECTURA_003.id
}

output "private_subnet_2_id" {
    value = aws_subnet.SBN_ARQUITECTURA_004.id
}

output "private_subnet_3_id" {
    value = aws_subnet.SBN_ARQUITECTURA_005.id
}

output "private_subnet_4_id" {
    value = aws_subnet.SBN_ARQUITECTURA_006.id
}