

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr 
  tags = {
    Name = var.vpc_name
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.id, 8, count.index * 2)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.id, 8, count.index * 2 + 1)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-${count.index + 1}-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW for new vpc"
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}



