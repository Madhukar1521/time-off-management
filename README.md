# time-off-management
![Architecture](https://github.com/Madhukar1521/time-off-management/assets/161786289/53adc2ac-e7b6-4d10-87a4-ae766065713f)

Attached is the architecture diagram detailing the solution based on the requirement


* The infrastructure is provisioned and managed using the Infrastructure as Code tool, Terraform.

* Changes in the git repository trigger an automated CI/CD pipeline, deploying the application to the AWS infrastructure.

* The application is served using HTTPS. This involves obtaining an SSL certificate (e.g., from AWS Certificate Manager) and configuring the Load Balancer to terminate SSL connections. HTTP traffic will be redirected to HTTPS

* The application is deployed across multiple Availability Zones (AZs) for high availability.

* An Elastic Load Balancer (ELB) distributes incoming traffic across multiple instances of the application deployed in different AZs

* Application servers reside in private subnets for security reasons, ensuring they are not directly accessible from the internet and the Load Balancer resides in a public subnet, accessible from the internet.

