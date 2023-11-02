resource "aws_api_gateway_rest_api" "java_lambda_api" {
  name        = "java_lambda_api"
  description = "Java Lambda on Terrraform"
}

resource "aws_api_gateway_resource" "java_lambda_api_gateway" {
  rest_api_id = "${aws_api_gateway_rest_api.java_lambda_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.java_lambda_api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "java_lambda_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.java_lambda_api.id}"
  resource_id   = "${aws_api_gateway_resource.java_lambda_api_gateway.id}"
  http_method   = "GET"
  authorization = "NONE"
}

# Unfortunately the proxy resource cannot match an empty path at the root of the API.
# To handle that, a similar configuration must be applied to the root resource that is built in to the REST API object:
resource "aws_api_gateway_method" "java_lambda_method_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.java_lambda_api.id}"
  resource_id   = "${aws_api_gateway_rest_api.java_lambda_api.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

