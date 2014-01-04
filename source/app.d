import ctini.ctini;

import vibe.d;

import vibelog.vibelog;

enum Config = IniConfig!"config.ini";

static this() {

	setLogFile(Config.Logging.filename, LogLevel.warn);
	auto router = new URLRouter();

	auto blogsettings = new VibeLogSettings;
	blogsettings.configName = "vibelog";
	blogsettings.siteUrl = URL.parse("http://localhost:8080/blog/");
	blogsettings.databaseHost = "krendil.ssh22.net";
	registerVibeLog(blogsettings, router);

	router.get("*", serveStaticFiles("./public/"));

	auto settings = new HTTPServerSettings;
	settings.port = Config.Network.port;
	listenHTTP(settings, router);
}
