resource "aws_security_group" "ALL-TRAFFIC" {
name = "ALL-TRAFFIC"
description = "Terraform created group"
vpc_id = aws_vpc.terraform-vpc.id


   ingress {
    from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}


   egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   
   
   }
   
   
   tags = {
   Name = "ALL-TRAFFIC"
   
}



}
