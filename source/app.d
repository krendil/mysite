import ctini.ctini;

import vibe.d;

import vibelog.vibelog;

enum Config = IniConfig!"config.ini";

static this() {

	setLogFile(Config.Logging.filename, LogLevel.warn);
	auto router = new URLRouter();

	auto blogsettings = new VibeLogSettings;
	blogsettings.configName = Config.Blog.configname;
	blogsettings.siteUrl = URL.parse(Config.Network.baseUrl);
	blogsettings.databaseHost = Config.Blog.dbhost;
	registerVibeLog(blogsettings, router);

	router.get("*", serveStaticFiles("./public/"));

	auto settings = new HTTPServerSettings;
	settings.port = Config.Network.port;
	listenHTTP(settings, router);
}
