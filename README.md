GitHub Repository Access Checker:

This script helps you list all GitHub users with read (pull) access to a given repository.
It uses the GitHub REST API, a personal access token (PAT) for authentication, and the jq command-line JSON processor.

It can be deployed and executed on an AWS EC2 instance (or any Linux-based environment with bash, curl, and jq installed).

1)Features:

Fetches the list of collaborators for a GitHub repository.

Filters and displays only those with read access (pull permission).

Useful for auditing access to your repositories.

2)Prerequisites:

Before running the script, ensure you have:-

-->AWS EC2 instance (Amazon Linux 2 or Ubuntu recommended).

-->Installed dependencies:

sudo yum install -y jq curl git   # For Amazon Linux
#OR
sudo apt-get update && sudo apt-get install -y jq curl git   # For Ubuntu/Debian


-->A GitHub Personal Access Token (PAT) with the repo scope:-

Create a PAT here: https://github.com/settings/tokens

3)Export your GitHub credentials in the shell environment:

export username="your_github_username"
export token="your_personal_access_token"

4) Usage

Clone this repository (or copy the script to your EC2 instance).

git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
chmod +x github_read_access_checker.sh


5)Run the script with:

./github_read_access_checker.sh <repo_owner> <repo_name>



Deployment on AWS EC2:

Launch an EC2 instance (Amazon Linux or Ubuntu).

SSH into the instance:

ssh -i your-key.pem ec2-user@<ec2-public-ip>


Install dependencies (jq, curl).

Set environment variables (username and token).

Run the script as shown above.



🔒Security Note

Never hardcode your GitHub credentials inside the script.

Use environment variables or AWS Secrets Manager for secure credential storage.

Ensure the EC2 instance has restricted access and proper IAM/security group rules.


📄License

This script is released under the MIT License.
