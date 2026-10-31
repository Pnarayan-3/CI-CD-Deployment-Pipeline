resource "local_file" "deployment_artifact" {
  filename = "${path.module}/deployment-${var.environment}.html"

  content = <<-EOF
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${var.app_name}</title>
    </head>
    <body>
        <h1>${var.app_name}</h1>
        <p>Environment: ${var.environment}</p>
        <p>Deployment Status: Successful</p>
    </body>
    </html>
  EOF
}