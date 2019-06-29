function define(script)
{
    script.Name = "action_UBChampion";
    script.Type = "ActionCustom";
    return 0;
}

function run(source, cState, dState, zone, server, params)
{
    local matchManager = server.GetMatchManager();
    local syncManager = server.GetChannelSyncManager();
    local worldDB = server.GetWorldDatabase();

	local current = matchManager.GetUBTournament();

	if(current && !current.GetPrevious().IsNull())
	{
        // Lastly award status effect to winner(s)
		local winners = [];

		local prevRef = UBTournamentRef();
		prevRef.SetUUID(current.GetPrevious());

        foreach(result in UBResult.LoadUBResultListByTournament(worldDB, prevRef))
        {
			if(result.GetTournamentRank() == 1)
			{
				winners.push(result);
			}
        }

		if(winners.len() > 0)
		{
			foreach(winner in winners)
			{
				local effect = StatusEffect();
				effect.SetEffect(2100);
				effect.SetStack(1);
				effect.SetEntity(winner.GetCharacter());
				local post = PostItem();
				local lobbyDB = server.GetLobbyDatabase();
				post.SetTimestamp(worldClock.SystemTime);
				if(PersistentObject.Register(effect, UUID()) && effect.Insert(worldDB))
				{
					syncManager.UpdateRecord(effect, "StatusEffect");
				}
				else
				{
					print("Failed to insert UB champion effect on: " + winner.GetCharacter());
				}
			}

			syncManager.SyncOutgoing();
		}
	}

    return Result_t.SUCCESS;
}