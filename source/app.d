import vibe.d;

import vibelog.vibelog;

static this() {

	setLogFile("/var/log/vibelog.log", LogLevel.warn);
	auto router = new URLRouter();

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
