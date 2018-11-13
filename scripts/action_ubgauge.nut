function define(script)
{
    script.Name = "action_UBGauge";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    if(params.len() < 3)
    {
        return Result_t.FAIL;
    }

	local gZone = server.GetZoneManager().GetGlobalZone(params[0].tointeger(),
        params[1].tointeger());
	local ubMatch = gZone != null ? gZone.GetUBMatch() : null;
    if(ubMatch == null)
	{
	    return Result_t.FAIL;
	}

    local gauge = ubMatch.GetGauge();
    gauge += params[2].tointeger();
	if(gauge < 0)
	{
		gauge = 0;
	}
	else if(gauge >= 1000000)
	{
		gauge = 1000000;
	}
	ubMatch.SetGauge(gauge);

    return Result_t.SUCCESS;
}