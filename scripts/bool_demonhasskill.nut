function define(script)
{
    script.Name = "bool_demonHasSkill";
    script.Type = "EventCondition";
    return 0;
}

// Check if any of the supplied skill IDs are directly on the summoned demon in any form
// - params[0]+: Skill IDs
function check(source, cState, dState, zone, value1, value2, params)
{
    local demon = dState != null ? dState.GetEntity() : null;
    if(demon == null)
    {
        return -1;
    }

    for(local i = 0; i < params.len(); i++)
    {
        local id = params[i].tointeger();

        foreach(skillID in demon.GetLearnedSkills())
        {
            if(skillID == id)
            {
                return 0;
            }
        }

        foreach(skillID in demon.GetAcquiredSkills())
        {
            if(skillID == id)
            {
                return 0;
            }
        }

        foreach(iSkillRef in demon.GetInheritedSkills())
        {
            local iSkill = iSkillRef.Get();
            if(iSkill != null && iSkill.GetSkill() == id)
            {
                return 0;
            }
        }
    }

    return -1;
}