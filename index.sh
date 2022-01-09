#!/bin/bash

. base.sh
. mysql.sh
. credentials.sh
. shinden/engine.sh

connect "$mysqlHost" "$mysqlUser" "$mysqlPassword" "$mysqlDB"

router
