#!/bin/sh

set -x
export NEW_RELIC_CONFIG_FILE=$(/usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ env | grep ^NEW_RELIC_CONFIG_FILE= | cut -d = -f2 | awk '{print $1 }')

if [ "$1" = "eventful" ];
then

    echo "==================="
    echo "Running Eventful"
    echo "==================="
    echo
    /usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ mix ecto.migrate
    /usr/local/bin/envconsul -consul consul.mcagrid.com -token $CONSUL_TOKEN -prefix $DEPLOY_ENV/ mix phx.server
fi