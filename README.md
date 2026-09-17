# Guía de Terraform desde cero

## Archivos

- **main.tf**: Aquí se definen los recursos de infraestructura que Terraform gestionará.
- **providers.tf**: Configuración de los proveedores que Terraform utilizará.
- **variables.tf**: Definición de las variables que se utilizarán en la configuración de Terraform.
- **terraform.tfstate**: Archivo que mantiene el estado de la infraestructura gestionada por Terraform.
- **dev.tfvars**: Archivo de variables específico para el entorno de desarrollo.
- **prod.tfvars**: Archivo de variables específico para el entorno de producción.

## Comandos básicos

terraform init -> inicializa el proyecto y descarga los proveedores necesarios
terraform plan -> muestra un plan de ejecución, indicando los cambios que se realizarán en la infraestructura
terraform apply -> aplica los cambios en la infraestructura según el plan generado
terraform apply --auto-approve -> aplica los cambios sin pedir confirmación
terraform destroy -> destruye la infraestructura creada por Terraform
terraform init -migrate-state -> inicializa el proyecto y migra el estado existente al backend configurado

## Workspaces

Los workspaces en Terraform permiten gestionar múltiples entornos de infraestructura dentro de un mismo proyecto. Por ejemplo, se pueden tener workspaces para los ambientes desarrollo, pruebas y producción.

Cada workspace tiene su propio archivo de estado, lo que permite mantener la configuración y el estado de la infraestructura separados para cada entorno.

Comandos básicos:

- terraform workspace list -> lista los workspaces existentes
- terraform workspace show -> muestra el workspace actual
- terraform workspace new [nombre] -> crea un nuevo workspace
- terraform workspace select [nombre] -> cambia al workspace especificado
- terraform workspace delete [nombre] -> elimina el workspace especificado

## Manejo de variables

- *Variables de entorno*: Siempre se deben nombrar con el prefijo `TF_VAR_`. Por ejemplo, para una variable llamada `region`, se debe definir la variable de entorno `TF_VAR_region`. Estas variables de entorno permiten sobrescribir los valores de las variables definidas en los archivos de Terraform y se utilizan para proporcionar valores dinámicos sin modificar los archivos de configuración directamente.

ejemplo:

```bash
export TF_VAR_region="us-east-1"
```

- *Archivos por ambiente*: Se pueden crear archivos de variables específicos para cada entorno, por ejemplo `dev.tfvars`, `prod.tfvars`, etc. Estos archivos permiten definir valores de variables que son específicos para cada ambiente y se pueden utilizar al ejecutar Terraform con la opción `-var-file`.

ejemplo:

```bash
terraform apply -var-file="dev.tfvars"
```
