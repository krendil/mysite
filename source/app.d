
import std.string;

import ctini.ctini;

import vibe.d;

import vibelog.vibelog;

import mymarkdown;

enum Config = IniConfig!"config.ini";

shared static this() {
    setLogFile(Config.Logging.filename, LogLevel.debug_);
}

string myFilter(string input) {
    return filterMyMarkdown(input);
}

static this() {

    auto router = new URLRouter();

    auto blogConf = Config.Blog;

    auto blogsettings = new VibeLogSettings;
    blogsettings.siteUrl = URL.parse(blogConf.baseUrl);
    blogsettings.databaseHost = blogConf.dbhost;
    blogsettings.databaseName = blogConf.configname;
    blogsettings.textFilters ~= &myFilter;

    registerVibeLog!(blogConf)(blogsettings, router);

    router.get("*", serveStaticFiles(Config.Blog.staticDir));

    auto settings = new HTTPServerSettings;
    settings.port = Config.Network.port;
    settings.options |= HTTPServerOption.parseFormBody | HTTPServerOption.parseURL;
    listenHTTP(settings, router);
}

