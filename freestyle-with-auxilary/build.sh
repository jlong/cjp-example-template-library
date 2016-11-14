echo "Creating CD..."
<% tracks.each { %>
echo "${it.number} ${it.name} ${it.length}"
<% } %>
echo "Done"
