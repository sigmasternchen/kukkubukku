#!/bin/bash

. shochu/utils.sh
. shochu/uri.sh
. shochu/router.sh
. shochu/mysql.sh
. shochu/cookies.sh
. shochu/sessions.sh

. shochu/shinden/engine.sh

. utils/auth.sh
. utils/headers.sh

. data/users.sh
. data/recipes.sh

. controller/users.sh
. controller/home.sh
. controller/backend.sh

. credentials.sh

connect "$mysqlHost" "$mysqlUser" "$mysqlPassword" "$mysqlDB"

router
