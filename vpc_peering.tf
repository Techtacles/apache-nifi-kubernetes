resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id = module.rds_vpc.vpc_id
  vpc_id      = module.eks_vpc.vpc_id
  auto_accept = true
  tags = {
    Side = "VPC Peering"
  }
  depends_on = [module.eks_vpc, module.rds_vpc]
}

resource "aws_route" "peering_routes" {
  route_table_id            = module.eks_vpc.route_table_id
  destination_cidr_block    = module.rds_vpc.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  depends_on                = [aws_vpc_peering_connection.vpc_peering]
}
