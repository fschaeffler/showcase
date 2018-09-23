# RDS Setup
MySQL

Dev/Test-MySQL

DB instance class: db.t2.micro
DB instance identifier: showcase
Master username: showcase_admin
Master password: <PASSWORD>
Database name: showcase_db

# Wait for instance to be ready

select inbound security group
add ec2-instance security group

# Run migrations

bin/rails db:migrate RAILS_ENV=development