#!/bin/bash
# Update installed packages and install Apache web server
yum update -y
yum install -y httpd

# Start and enable Apache service
systemctl start httpd
systemctl enable httpd

# Retrieve metadata to customize the landing page
INSTANCE_ID=$(curl -s [http://169.254.169.254/latest/meta-data/instance-id](http://169.254.169.254/latest/meta-data/instance-id))
AVAILABILITY_ZONE=$(curl -s [http://169.254.169.254/latest/meta-data/placement/availability-zone](http://169.254.169.254/latest/meta-data/placement/availability-zone))

# Generate landing page
cat <<EOF> /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>AWS Scalable Infrastructure</title>
</head>
<body>
    <h1>Application Running on AWS</h1>
    <p><b>Instance ID:</b> $INSTANCE_ID</p>
    <p><b>Availability Zone:</b> $AVAILABILITY_ZONE</p>
</body>
</html>
EOF
