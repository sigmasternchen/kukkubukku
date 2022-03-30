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
