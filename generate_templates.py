import os

# Directorio donde se encuentran las plantillas
TEMPLATE_DIR = "templates"
# Directorio de salida
OUTPUT_DIR = "output"

def read_template(template_name):
    with open(os.path.join(TEMPLATE_DIR, template_name), 'r') as file:
        return file.read()

def generate_templates(output_dir=OUTPUT_DIR, app_name="MyApp", resource_prefix="MyPrefix"):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    templates = [
        "api_gateway_with_apikey_no_cors.yaml",
        "gateways_routes.yaml",
        "iam_roles.yaml",
        "lambda_secretparams.yaml",
        "lambdas_external.yaml",
        "lambdas_internal.yaml",
        "parameter_store.yaml",
        "rds.yaml",
        "s3_bucket.yaml",
        "secrets_manager.yaml",
        "security_groups.yaml",
        "vpc_subnets.yaml"
    ]

    for template_name in templates:
        content = read_template(template_name)
        content = content.replace("MRGApp", app_name).replace("MRG", resource_prefix)
        with open(os.path.join(output_dir, template_name), "w") as f:
            f.write(content)

if __name__ == "__main__":
    generate_templates()
# usage: generate_templates(output_dir="output", app_name="MyApp", resource_prefix="MyPrefix")

