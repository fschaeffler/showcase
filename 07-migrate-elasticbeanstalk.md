sudo apt-get install python3-pip
sudo pip3 install awsebcli

update user rights in iam and add full access for elastic beanstalk

eb init -p ruby

select Frankfurt
eb create production
eb use production
eb setenv SECRET_KEY_BASE=97cbf8b5493c15b2403ed35b9b7503a6674667bad17a8455072adf540a027610dc357a92ea6819a03b2afb1a0122e5abfba815ad56d3b72cf6a732a3a0153868

git add -A .; git commit -m 'stashed'
eb deploy --staged