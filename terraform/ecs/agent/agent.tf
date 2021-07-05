data "template_file" "container_definitions" {
  template = file("${path.module}/templates/container_definitions.json")
  vars = {
    X_PAI_TOKEN = var.X_PAI_TOKEN
    PAI_API_KEY = var.PAI_API_KEY
    APIDEVURL   = var.APIDEVURL
  }
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "agentd_task"
  container_definitions = data.template_file.container_definitions.rendered
  execution_role_arn    = aws_iam_role.role.arn

  volume {
    name      = "proc"
    host_path = "/proc"
  }

  volume {
    name      = "dockersocket"
    host_path = "/var/run/docker.sock"
  }

  volume {
    name      = "dockerlogs"
    host_path = "/var/lib/docker/containers"
  }

  volume {
    name      = "cgroup"
    host_path = "/sys/fs/cgroup"
  }

  volume {
    name      = "logs"
    host_path = "/var/log"
  }

  volume {
    name      = "hostname"
    host_path = "/etc/hostname"
  }

  volume {
    name = "packetai"
    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
      driver        = "local"
    }
  }

  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "service" {
  name                = "agentd_${var.cluster_name}"
  cluster             = data.aws_ecs_cluster.cluster.id
  task_definition     = aws_ecs_task_definition.task_definition.arn
  scheduling_strategy = "DAEMON"
  launch_type         = "EC2"
}
