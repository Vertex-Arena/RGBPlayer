#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

bool RGB[65] = { false, ... };

int r1 = 255, g1 = 0, b1 = 0;

public Plugin myinfo = 
{
    name = "Sistema RGB", 
    author = "inactivo", 
    description = "Togglea el RGB del Jugador", 
    version = "1.4", 
    url = ""
};

public void OnPluginStart()
{
    LoadTranslations("common.phrases");
    LoadTranslations("playerrgb.phrases");
    RegAdminCmd("sm_rgb", Command_RGB, ADMFLAG_CHEATS, "Uso: sm_rgb");
}

public void OnGameFrame()
{
    if (r1 > 0 && b1 == 0)
    {
        r1--;
        g1++;
    }
    if (g1 > 0 && r1 == 0)
    {
        g1--;
        b1++;
    }
    if (b1 > 0 && g1 == 0)
    {
        b1--;
        r1++;
    }
    for (int i = 1; i <= MaxClients; i++)if (IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i) && RGB[i])
    {
        SetEntityRenderColor(i, r1, g1, b1, 200);
    }
}

public void OnClientPostAdminCheck(int client)
{
    RGB[client] = false;
}

public Action Command_RGB(int client, int args)
{
    RGB[client] = !RGB[client];
    if (RGB[client])
    {
        PrintToChatAll("[SM] %t", "Activated RGB", client);
        SetEntityRenderColor(client, r1, g1, b1, 200);
    }
    else
    {
        PrintToChatAll("[SM] %t", "Deactivated RGB", client);
        SetEntityRenderColor(client, 255, 255, 255, 255);
    }
    
    return Plugin_Handled;
}