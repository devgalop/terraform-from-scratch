# Guía de Terraform desde cero

Se deben crear los archivos:

- main.tf : Recursos
- providers.tf : Configuración de proveedores
- variables.tf: Definición de variables

terraform init -> inicializa el proyecto y descarga los proveedores necesarios

terraform plan -> muestra un plan de ejecución, indicando los cambios que se realizarán en la infraestructura

terraform apply -> aplica los cambios en la infraestructura según el plan generado

terraform apply --auto-approve -> aplica los cambios sin pedir confirmación

terraform destroy -> destruye la infraestructura creada por Terraform

terraform init -migrate-state -> inicializa el proyecto y migra el estado existente al backend configurado
