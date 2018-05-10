import vibe.d;
import std.conv : to;
import std.process : environment;

shared static this()
{
    logInfo("Environment dump");
    auto env = environment.toAA;
    foreach(k, v; env)
        logInfo("%s = %s", k, v);

    auto host = environment.get("HELLO_HOST", "127.0.0.1");
    auto port = to!ushort(environment.get("HELLO_PORT", "8080"));

    auto router = new URLRouter;
    router.registerRestInterface(new HelloImpl());

    auto settings = new HTTPServerSettings;
    settings.port = port;
    settings.bindAddresses = [host];

    listenHTTP(settings, router);

    logInfo("Please open http://%s:%d/ in your browser.", host, port);
}

interface Hello
{
    @method(HTTPMethod.GET)
    @path("hello")
    string hello();

    @method(HTTPMethod.GET)
    @path("healthz")
    string healthz();
}

class HelloImpl : Hello
{
    string hello() @safe
    {
        return "Hello visitor!";
    }

    string healthz() @safe
    {
        return "OK";
    }
}

