import vibe.d;
import std.conv : to;
import std.process : environment;
import std.typecons : Nullable;

shared static this()
{
    logInfo("Environment dump");
    auto env = environment.toAA;
    foreach(k, v; env)
        logInfo("%s = %s", k, v);

    auto host = environment.get("HELLO_HOST", "0.0.0.0");
    auto port = to!ushort(environment.get("HELLO_PORT", "17890"));

    auto router = new URLRouter;
    router.registerRestInterface(new HelloImpl());

    auto settings = new HTTPServerSettings;
    settings.port = port;
    settings.bindAddresses = [host];

    listenHTTP(settings, router);

    logInfo("Please open http://%s:%d/hello in your browser.", host, port);
}

interface Hello
{
    @method(HTTPMethod.GET)
    @path("hello")
    @queryParam("name", "name")
    Msg hello(Nullable!string name);

    @method(HTTPMethod.GET)
    @path("healthz")
    string healthz();
}

class HelloImpl : Hello
{
    Msg hello(Nullable!string name) @safe
    {
        logInfo("hello called");
        return Msg(format("Hello %s", name.isNull ? "visitor" : name));
    }

    string healthz() @safe
    {
        logInfo("healthz called");
        return "OK";
    }
}

struct Msg
{
    string msg;
}
