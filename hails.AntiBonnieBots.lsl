integer MyChannel = 5050;

default
{   
    on_rez(integer start_param)
    {
        llResetScript();
    }
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }
    state_entry()
    {;
        llRequestPermissions(llGetOwner(), PERMISSION_SILENT_ESTATE_MANAGEMENT);
        llListen(MyChannel, "", llGetOwner(), "");
        llInstantMessage(llGetOwner(), llGetScriptName() + " is now Online in the " + llGetRegionName() + " Region." );
    }
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_SILENT_ESTATE_MANAGEMENT)
        {
            llInstantMessage(llGetOwner(), llGetScriptName() + " will suppress the default Estate Action notifications. \nSay /5050 bonnie.help for Commands");
            llSetTimerEvent(1);
        }
        else
        {
            llInstantMessage(llGetOwner(), llGetScriptName() + " will not suppress the default Estate Action notications. \nIf you find the default notifications annoying just reset/re-rez me to change this ♥ \nSay /5050 bonnie.help for Commands");
            llSetTimerEvent(1);
        }
    }
    listen(integer chan, string name, key id, string msg)
    {
        key object_owner = llGetOwner();
        key speakee = llGetOwnerKey(id);
        if (msg == "bonnie.reset")
        {
            llOwnerSay("Command acknowledged.");
            llSleep(2.0);
            llResetScript();
        }
         else if (msg == "bonnie.help")
        {
            llOwnerSay("Hails.AntiBonnie has the following commands:");
            llOwnerSay("bonnie.reset .............. Reset the Script");
            llOwnerSay("bonnie.help  ................ This help list");
        }
    }
    timer()
    {
        llSensorRepeat("", "", AGENT_BY_USERNAME, 200.0, PI, 1.0);
    }
    sensor(integer num_detected)
    {
        integer i;
        for (i = 0; i < num_detected; i++)
        {
            key user = llDetectedKey(i);
            string name = llDetectedName(i);
            string lower_name = llToLower(name);
            integer action = ESTATE_ACCESS_BANNED_AGENT_ADD;
            llOwnerSay(llGetScriptName() + " has detected " + name + " within the " + llGetRegionName() + " Region ");
            if (llSubStringIndex(lower_name, "bonniebelle") != -1)
            {
                llManageEstateAccess(action, user);
                llInstantMessage(user, "Hello " + name + ", \nyou have been Banned from the Simulator " + llGetRegionName() + " as you were detected to be apart of BonnieBots.com \nIf you believe this Ban has occurred in error, please Contact " + llKey2Name(llGetOwner()) + " via IM");
                llInstantMessage(llGetOwner(), llGetScriptName() + " has Banned user: " + name + " \nFrom the " + llGetRegionName() + " Region. \nReason: Suspected BonnieBot");
            }
        }
    }
}
