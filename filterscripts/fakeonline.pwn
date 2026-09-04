#include <a_samp>

/*
    FakeOnline — filterscript
    Плагин: plugins/FakeOnline.dll (или .so на Linux)
    Конфиг: scriptfiles/fakeonline.ini
    Геймод xhatw.amx НЕ трогаем.
*/

forward OnSendPlayerCount(count);

new bool:g_Enabled = true;
new g_FakeOnline = 28;
new g_RandomRange = 4;

stock TrimString(str[])
{
    new start, end = strlen(str) - 1;
    while (str[start] == ' ' || str[start] == '\t' || str[start] == '\r' || str[start] == '\n') start++;
    while (end > start && (str[end] == ' ' || str[end] == '\t' || str[end] == '\r' || str[end] == '\n')) end--;
    str[end + 1] = EOS;
    if (start > 0)
    {
        new i;
        for (i = 0; str[start + i]; i++) str[i] = str[start + i];
        str[i] = EOS;
    }
}

stock LoadFakeOnlineSettings()
{
    if (!fexist("fakeonline.ini"))
    {
        new File:f = fopen("fakeonline.ini", io_write);
        if (f)
        {
            fwrite(f, "Enabled=1\r\nFakeOnline=28\r\nRandomRange=4\r\n");
            fclose(f);
        }
    }

    new File:f = fopen("fakeonline.ini", io_read);
    if (!f) return;

    new line[128];
    while (fread(f, line))
    {
        TrimString(line);
        if (!line[0] || line[0] == ';' || line[0] == '#') continue;

        new pos = strfind(line, "=");
        if (pos == -1) continue;

        new key[32], val[32];
        strmid(key, line, 0, pos);
        strmid(val, line, pos + 1, strlen(line));
        TrimString(key);
        TrimString(val);

        if (!strcmp(key, "Enabled", true)) g_Enabled = !!strval(val);
        else if (!strcmp(key, "FakeOnline", true)) g_FakeOnline = strval(val);
        else if (!strcmp(key, "RandomRange", true)) g_RandomRange = strval(val);
    }
    fclose(f);
    if (g_FakeOnline < 0) g_FakeOnline = 0;
    if (g_RandomRange < 0) g_RandomRange = 0;
}

public OnFilterScriptInit()
{
    LoadFakeOnlineSettings();
    print("========================================");
    print("  FakeOnline loaded (xhatw compatible)");
    print("  Config: scriptfiles/fakeonline.ini");
    printf("  Show: %d (+/- %d)", g_FakeOnline, g_RandomRange);
    print("  Reload: /rcon reloadfs fakeonline");
    print("========================================");
    return 1;
}

public OnFilterScriptExit() return 1;

public OnSendPlayerCount(count)
{
    if (!g_Enabled) return count;
    new fake = g_FakeOnline;
    if (g_RandomRange > 0)
        fake += random(g_RandomRange * 2 + 1) - g_RandomRange;
    if (fake < 0) fake = 0;
    return fake;
}

forward FakeOnline_Reload();
public FakeOnline_Reload()
{
    LoadFakeOnlineSettings();
    printf("[FakeOnline] reloaded -> %d (+/-%d)", g_FakeOnline, g_RandomRange);
    return 1;
}
