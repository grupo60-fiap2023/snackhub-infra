resource "aws_ecs_cluster" "ecs-cluster-terraform" {
  name = "ecs-cluster-terraform"
}

resource "aws_ecs_task_definition" "tarefa-imagem" {
  family = "family-terraform"
  network_mode = "awsvpc"
  cpu = 1024
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  container_definitions = jsonencode([
    {
        name = "service"
        image = "${aws_ecr_repository.ecr_terraform.repository_url}:latest"
        cpu = 1024
        memory = 2048
        portMappings = [
            {
                name = "containerapp-8080-tcp",
                containerPort = 8080
                hostPort = 8080
                protocol = "tcp"
                appProtocol = "http"
            },{
                name = "containerapp-3306-tcp",
                containerPort = 3306
                hostPort = 3306
                protocol = "tcp"
                appProtocol = "http"
            }
        ]
        environment : [
            { name : "MYSQL_USERNAME", value : "admin" },
            { name : "MYSQL_PORT", value : "3306" },
            { name : "MYSQL_PASSWORD", value : "12345678" },
            { name : "MYSQL_SCHEMA", value : "snackhub" },
            { name : "MYSQL_URL", value : aws_db_instance.snackhub-db.address }
        ]
    }
  ])
}



# resource "aws_ecs_service" "app-svc" {
#   name = "app-svc"
#   cluster = aws_ecs_cluster.ecs-cluster-terraform.id
#   task_definition = aws_ecs_task_definition.tarefa-imagem
# }