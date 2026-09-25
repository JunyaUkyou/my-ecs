
resource "aws_ecr_repository" "frontend" {
  image_tag_mutability = "MUTABLE"
  name                 = "${var.app_name}-frontend"
  tags                 = {}
  tags_all             = {}
  force_delete         = true
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = false
  }
}


resource "aws_ecr_repository" "backend" {
  image_tag_mutability = "MUTABLE"
  name                 = "${var.app_name}-backend"
  tags                 = {}
  tags_all             = {}
  force_delete         = true
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = false
  }
}
