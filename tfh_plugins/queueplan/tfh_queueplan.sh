#!/bin/sh

determine_workspace_id () {
    echo `exec $0 workspace show -org $org -name $name | grep "^id.* = " | awk '{ print \$4""\$3 }'`
}

queueplan () {
    workspaceId="$1"
    message="$2"

    echodebug "Trying to queue plan for workspaceId: $workspaceId"

    curl -s -X POST \
    https://app.terraform.io/api/v2/runs \
    -H "Authorization: Bearer $token" \
    -H 'Content-Type: application/vnd.api+json' \
    -d "{
    \"data\": {
      \"attributes\": {
        \"is-destroy\":false,
        \"message\": \"$message\"
      },
      \"type\":\"runs\",
      \"relationships\": {
        \"workspace\": {
          \"data\": {
            \"type\": \"workspaces\",
            \"id\": \"$workspaceId\"
          }
        }
      }
    }}"
}

tfh_queueplan () {
  message="$5"

  workspaceId=$( determine_workspace_id )

  if [ $workspaceId ]; then
      queueplan "$workspaceId" "$message"
  else
      echo "No workspaceId could be determined for workspace name: $name"
      exit 1
  fi

}