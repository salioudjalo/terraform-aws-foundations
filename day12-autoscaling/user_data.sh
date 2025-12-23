    #!/bin/bash
    yum update -y
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform Day 12 ASG</h1>" > /var/www/html/index.html