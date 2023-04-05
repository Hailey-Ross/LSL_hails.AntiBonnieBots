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
    {
        llOwnerSay( " \"" + llGetScriptName() + "\" is now Online");
        llSetTimerEvent(1);;
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
            key owner = llGetOwner();
            string owneruuid = owner;
            string contact = llKey2Name(owner);
            integer action = ESTATE_ACCESS_BANNED_AGENT_ADD;
            string name = llDetectedName(i);
            string region_name = llGetRegionName();
            string lower_name = llToLower(name);
            if (llSubStringIndex(lower_name, "bonniebelle") != -1)
            {
                //llAddToLandBanList(user, 0);
                llManageEstateAccess(action, user);
                llInstantMessage(user, "Hello " + name + ", you have been Banned from the Simulator " + region_name + " as you have been detected as a BonnieBot. If you believe this Ban has occurred in error, please Contact " + contact + " via IM");
                llInstantMessage(owneruuid, llGetScriptName() + " has Banned user: " + name + " | From the " + region_name + " Region for being a Suspected BonnieBot");
            }
        }
    }
}
