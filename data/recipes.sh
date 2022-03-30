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

getRecipeById() {
	local id="$(echo "$1" | sed 's/[^0-9]//g')"

	query <<EOF
		SELECT
			recipes.name,
			description,
			ingredients.name,
			ingredients.quantity,
			users.id,
			users.username
		FROM recipes
		INNER JOIN ingredients
			ON recipes.id = ingredients.recipeFk
		INNER JOIN users
			ON recipes.userFk = users.id
		WHERE recipes.id = $id
EOF
}

addRecipe() {
	local name="$1"
	local description="$2"
	local username="$3"
	local qts="$4"
	local ingredients="$5"

	local nrIngredients="$(echo "$qts" | wc -l)"

	template <(cat <<EOF
		START TRANSACTION;

		SELECT
			@uid := id
		FROM users
		WHERE username = '$(escape "$username")';

		INSERT INTO recipes
			(userFk, name, description) VALUES
			(@uid, '$(escape "$name")', '$(escape "$description")');

		SELECT @rid := LAST_INSERT_ID();

		{{ for i in \$(seq $nrIngredients); do }}
			INSERT INTO ingredients
				(recipeFk, name, quantity) VALUES
				(@rid,
					'{{ escape "\$(echo "\$ingredients" | tail -n +\$i | head -n 1)" | tr -d \\\\n }}',
					'{{ escape "\$(echo "\$qts" | tail -n +\$i | head -n 1)" | tr -d \\\\n }}'
				);
		{{ done }}

		COMMIT;
EOF
	) | execute
}
