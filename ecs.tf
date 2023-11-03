resource "aws_ecs_cluster" "ecs-cluster-terraform" {
  name = "ecs-cluster-terraform"
}

resource "aws_ecs_task_definition" "tarefa-imagem" {
  family = "family-terraform"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
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
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
}

resource "aws_ecs_service" "app-svc" {
  name = "app-svc"
  cluster = aws_ecs_cluster.ecs-cluster-terraform.id
  task_definition = aws_ecs_task_definition.tarefa-imagem.arn
  desired_count = 1
  network_configuration {
    subnets = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    security_groups = [aws_security_group.sec-group.id]
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}