import vibe.d;

void index(HttpServerRequest req, HttpServerResponse res) {
	res.renderCompat!("index.dt", HttpServerRequest, "req")
	(Variant(req));
}

static this() {
	auto router = new UrlRouter();
	router.get("/", &index);

	auto settings = new HttpServerSettings;
	settings.port = 80;

	listenHttp(settings, router);
}
