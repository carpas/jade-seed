require! {
	express
	\./config : {serverPort, distDir}
}


port = process.env.PORT or serverPort
app = express!

options = do
	root: distDir

app
	..use express.static __dirname + distDir

	..get \/:file, (req, res) ->
		res.sendFile req.params.file + ".html", options

	..listen port, do
		console.log "Listening on port #port"
