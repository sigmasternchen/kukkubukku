#!/bin/bash

getRecipesByUsername() {
	local username="$1"

	query <<EOF
		SELECT
			recipes.id,
			name
		FROM recipes
		INNER JOIN users
			ON recipes.userFk = users.id
		WHERE
			users.username = '$(escape "$username")'
EOF
}
