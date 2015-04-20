#!/bin/bash
set -e

MASTER_TOKEN="$1"
CLIENT_TOKEN="$2"

create_acl() {
    curl -X PUT "http://localhost:8500/v1/acl/create?token=$MASTER_TOKEN" \
        -d '{"Name": "agent_policy", "Type": "client", "Rules": "service \"\" {policy = \"write\"}"}'
}

if [[ -z "$CLIENT_TOKEN" ]]; then
    create_acl
elif [[ "$(curl -s http://localhost:8500/v1/acl/info/$CLIENT_TOKEN?token=$MASTER_TOKEN)" == "null" ]]; then
    create_acl
else
    echo "{ \"ID\":\"$CLIENT_TOKEN\" }"
fi

# EOF
