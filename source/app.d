
import std.string;

import ctini.ctini;

import vibe.d;

import vibelog.vibelog;

enum Config = IniConfig!"config.ini";

static this() {

    setLogFile(Config.Logging.filename, LogLevel.info);
    auto router = new URLRouter();

    auto blogConf = Config.Blog;

    auto blogsettings = new VibeLogSettings;
    blogsettings.siteUrl = URL.parse(blogConf.baseUrl);
    blogsettings.databaseHost = blogConf.dbhost;
    blogsettings.databaseName = blogConf.configname;

    registerVibeLog!(blogConf)(blogsettings, router);

    router.get("*", serveStaticFiles(Config.Blog.staticDir));

    auto settings = new HTTPServerSettings;
    settings.port = Config.Network.port;
    settings.options |= HTTPServerOption.parseFormBody | HTTPServerOption.parseURL;
    listenHTTP(settings, router);
}

