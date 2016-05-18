require! express


port = process.env.PORT or 8000
app = express!

options = do
	root: \app/dist

app
	..use express.static __dirname + \/app/dist/

	..get \/:file, (req, res) ->
		res.sendFile req.params.file + ".html", options

	..listen port, do
		console.log "Listening on port #port"
