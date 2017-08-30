function define(script)
{
    script.Name = "spin";
    return 0;
}

function prepare(eState, manager)
{
	local aiState = eState.GetAIState();
	aiState.OverrideAction("combat", "spin");
	aiState.OverrideAction("idle", "spin");
    return 0;
}

function spin(eState, manager, now)
{
    // Rotate more whenever rotation completes
    if(!eState.IsRotating())
    {
        local rot = eState.GetCurrentRotation();
        rot += 1.0;
        eState.Rotate(rot, now);
        return 1;
    }
    
    return 0;
}