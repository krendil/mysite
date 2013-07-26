import vibe.d;

import vibelog.vibelog;

void index(HTTPServerRequest req, HTTPServerResponse res) {
    auto title = "Main page";
	res.renderCompat!("index.dt", string, "title")(title);
}

static this() {
	auto router = new URLRouter();

	router.get("/", &index);

	auto blogsettings = new VibeLogSettings;
	blogsettings.configName = "vibelog";
	blogsettings.siteUrl = URL.parse("http://localhost:8080/blog/");
	blogsettings.databaseHost = "krendil.ssh22.net";
	registerVibeLog(blogsettings, router);

	router.get("*", serveStaticFiles("./public/"));

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	listenHTTP(settings, router);
}
