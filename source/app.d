import ctini.ctini;

import vibe.d;

import vibelog.vibelog;

enum Config = IniConfig!"config.ini";

static this() {

    setLogFile(Config.Logging.filename, LogLevel.warn);
    auto router = new URLRouter();

    foreach( s; Config.Blogs.expand ) {
        auto blogsettings = new VibeLogSettings;
        blogsettings.siteUrl = URL.parse(s.baseUrl);
        blogsettings.databaseHost = s.dbhost;
        blogsettings.databaseName = s.configname;
        registerVibeLog!s(blogsettings, router);
    }

    router.get("*", serveStaticFiles("./public/"));

    auto settings = new HTTPServerSettings;
    settings.port = Config.Network.port;
    listenHTTP(settings, router);
}
