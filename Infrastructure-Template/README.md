Implementation of Azure infrastructure using Terraform 

A simple implementation of Azure infrastructure using Terraform. It includes an Application Gateway for public access to App Services (frontend) and an internal Load Balancer distributing traffic to backend VMs running containerized microservices.

![image](https://github.com/user-attachments/assets/6784d9a8-bbfc-4631-bbb6-0d58c8ab71d6)



Architecture Overview
 
•	User hits the domain name of the  Application Gateway via internet.

•	Based on the path/ URI of the URL Application gateway performs Path-based routing to App Services or to  the Load Balancer.
/login → App Service 1
/checkout/ → App Service 2
/payment/ → Routed to Load Balancer instead of a direct App Service.

•	Load Balancer distributes /payment/ traffic to VM1 or  VM2.

What the Terraform Configuration Includes
1. Resource Group and Network
•	Resource Group to logically group resources.
•	Virtual Network with two subnets:
o	One for the Azure Application Gateway.
o	Another subnet for VMs and internal Load Balancer.
2. App Services (Frontend Tier)
•	Deploys three App Services:
•	/login → App Service 1
•	/checkout/ → App Service 2
•	/payment/ → Routed to Load Balancer instead of a direct App Service.
•	These are configured to scale independently and serve the microservice APIs.
3. Application Gateway (Layer 7 Routing)
•	Front-facing component with a Public IP.
•	Performs path-based routing:
	Routes /login/ and /checkout/  to respective App Services.
	Routes /payment/ to the Internal Load Balancer.
4. Virtual Machines (Backend Tier for Payment)
•	Two Linux VMs are deployed to handle the /payment/ route.
•	Each VM runs a Flask application via Docker and serves responses dynamically.
•	Traffic between these VMs are balanced using a Load Balancer.
5. Internal Load Balancer (Layer 4 Routing)
•	Located in the backend-subnet.
•	Distributes traffic to the two VMs based on IP-based routing.
•	Backend pool includes NICs associated with each VM.
6. Security and Networking
•	NSGs are applied to appropriate subnets to allow HTTP/S traffic.
•	Subnets are defined with specific address ranges for clean segregation.
•	Backend VMs are secured and accessible only via load balancer.
________________________________________


