#!/bin/bash


#######################################################################################
#Description    : Script to list all the users having access to a given Github repo
#Author         : Vishnu M V
#Version        : 1.1
#Created On     : 21/09/25
#Usage          : ./github_read_access_checker.sh <repo_owner> <repo_name>
#Requirements   :
#   - bash, curl, jq installed
#   - GitHub Personal Access Token (PAT) with 'repo' scope
#   - Environment variables: username, token
#License        : MIT
#########################################################################################


# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Helper function to validate input and pre-requisites
function helper {
        expected_cmd_args=2
        if [ $# -ne $expected_cmd_args ];
         then
           echo "Incorrect Usage"
           echo "Usage: ./github_read_access_checker.sh <org_name> <repo_name> "
                exit 1
        fi

        if [[ -z "$USERNAME" || -z "$TOKEN" ]]; then
        echo "Please export 'username' and 'token' before running the script."
        exit 1
        fi

        if ! command -v jq &>/dev/null; then
        echo "'jq' is required but not installed. Run: sudo apt install jq"
        exit 1
        fi
                }

# Call helper at the start
helper "$@"


# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}


# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
