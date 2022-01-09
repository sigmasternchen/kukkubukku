#!/bin/bash

. shochu/utils.sh
. shochu/uri.sh
. shochu/router.sh
. shochu/mysql.sh
. shochu/credentials.sh
. shochu/shinden/engine.sh

connect "$mysqlHost" "$mysqlUser" "$mysqlPassword" "$mysqlDB"

router
