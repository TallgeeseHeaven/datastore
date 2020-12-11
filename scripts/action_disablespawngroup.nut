function define(script)
{
    script.Name = "action_disableSpawnGroup";
    script.Type = "ActionCustom";
    return 0;
}

// Disable the supplied spawn groups in the current zone
// - params[0+]: Spawn group IDs
function run(source, cState, dState, zone, server, params)
{
    if(zone != null && params.len() > 0)
    {
        zone.EnableDisableSpawnGroup(params, false, server.GetWorldClockTime());

        return Result_t.SUCCESS;
    }

    return Result_t.FAIL;
}