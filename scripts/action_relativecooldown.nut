function define(script)
{
    script.Name = "action_relativeCooldown";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 3 || cState == null)
    {
        return Result_t.FAIL;
    }

    local cooldownID = params[0].tointeger();
    local toHour = params[1].tointeger();
    local toMin = params[2].tointeger();
    local toMerge = toHour * 100 + toMin;

    local clock = server.GetWorldClockTime();
    local now = clock.SystemTime;
    local fromMerge = clock.SystemHour * 100 + clock.SystemMin;

    local timeDelta = 0;
    if(fromMerge < toMerge)
    {
        timeDelta = toMerge - fromMerge;
    }
    else
    {
        timeDelta = 86400 -
            (((clock.SystemHour * 60) + clock.SystemMin) * 60) +
            (((toHour * 60) + toMin) * 60);
    }

    if(params.len() >= 4)
    {
        // Add day offset
        timeDelta = timeDelta + 86400 * params[3].tointeger();
    }

    cState.GetEntity().SetActionCooldownsEntry(cooldownID, now + timeDelta);

    return Result_t.SUCCESS;
}