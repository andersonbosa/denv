# denv/README.md

### notes

- Generate a random password using the 'openssl' command
random_password=$(openssl rand -base64 12)

- Run the Docker container and pass the generated password as an environment variable
docker run --rm -e VNC_PASSWORD="$random_password" your_image_name
