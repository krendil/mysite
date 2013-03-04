import vibe.d;

void index(HttpServerRequest req, HttpServerResponse res) {
    auto title = "Main page";
	res.renderCompat!("index.dt", string, "title")(title);
}

static this() {
	auto router = new UrlRouter();
	router.get("/", &index);
	router.get("*", serveStaticFiles("./public/"));

	auto settings = new HttpServerSettings;
	settings.port = 8080;

	listenHttp(settings, router);
}
