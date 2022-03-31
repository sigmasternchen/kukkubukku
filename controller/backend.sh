#!/bin/bash

route GET "/backend" backendHome
backendHome() {
	requireLoggedIn
	htmlContent
	endHeaders

	title="Backend"
	content="$(getRecipesByUsername "$username" | template "templates/backend.fragment.templ")"
	template "templates/layout.html.templ"
}

route GET "/backend/new" backendNew
backendNew() {
	requireLoggedIn
	htmlContent
	endHeaders

	title="Backend - New"
	content="$(template "templates/backend.new.fragment.templ")"
	template "templates/layout.html.templ"
}

route POST "/backend/new" backendAdd
backendAdd() {
	requireLoggedIn
	cacheFormData

	name="$(formData "name")"
	description="$(formData "description")"
	qts="$(formData "qts")"
	ingredients="$(formData "ingredients")"
	tags="$(formData "tags" | tr '[:upper:]' '[:lower:]')"

	if test "$(echo "$qts" | wc -l)" -ne "$(echo "$ingredients" | wc -l)"; then
		status 400
		endHeaders
		return
	fi

	addRecipe "$name" "$description" "$username" "$qts" "$ingredients" "$tags"

	redirect "/backend"
	endHeaders
}
