function define(script)
{
    script.Name = "bool_currentInstance";
    script.Type = "EventCondition";
    return 0;
}

// Check if the current instance is one of the supplied values
// - params[0]+: list of zone instance IDs
function check(source, cState, dState, zone, value1, value2, params)
{
	local instance = zone.GetZoneInstance();
    if(instance != null)
    {
        local cInstance = instance.GetDefinitionID();
        for(local i = 0; i < params.len(); i++)
        {
            if(params[i].tointeger() == cInstance)
            {
                return 0;
            }
        }
    }

    return -1;
}