#!/bin/bash

route GET "/" home
home() {
	htmlContent
	endHeaders
	
	title="Home"
	content="$(template "templates/home.fragment.templ")"
	template "templates/layout.html.templ"
}


route GET "/recipe" recipe
recipe() {
	id="$(queryString "id")"

	result="$(getRecipeById "$id")"

	if test -z "$result"; then
		"$_404"
		return
	fi

	htmlContent
	endHeaders

	name="$(echo "$result" | head -n 1 | getColumns 1)"
	description="$(echo "$result" | head -n 1 | getColumns 2)"
	uid="$(echo "$result" | head -n 1 | getColumns 5)"
	author="$(echo "$result" | head -n 1 | getColumns 6)"
	qts="$(echo "$result" | getColumns 4)"
	ingredients="$(echo "$result" | getColumns 3)"
	nrIngredients="$(echo "$qts" | wc -l)"

	title=""
	content="$(template "templates/recipe.fragment.templ")"
	template "templates/layout.html.templ"
}
