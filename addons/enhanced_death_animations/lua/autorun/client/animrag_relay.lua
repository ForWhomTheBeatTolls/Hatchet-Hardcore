
--因为net命令不能直接在server端和server端之间传递数据，但我又不想用全局变量，所以出此下策。
--反正对性能没影响（大概在一微秒左右？）

----------------------------------------------------------------------------------------
--一般的Death与Crawl，Crawl与Revive之间的ORag与ARag传递
net.Receive("AnimRag_Death_T_Crawl_sTc", function()
	net.Start("AnimRag_Death_T_Crawl_cTs")
		net.WriteInt(net.ReadInt(32), 32)		--ORag的ID
		net.WriteFloat(net.ReadFloat())			--Death动画的持续时间
	net.SendToServer()
end)


net.Receive("AnimRag_Crawl_T_Reviv_sTc", function()
	net.Start("AnimRag_Crawl_T_Reviv_cTs")
		net.WriteInt(net.ReadInt(32), 32)		--ORag的ID
		net.WriteInt(net.ReadInt(32), 32)		--ARag的ID
	net.SendToServer()
end)


----------------------------------------------------------------------------------------
--如果一个NPC前去Revive一个Ragdoll，则告诉Death端该NPC的敌友信息，因为敌友信息在Revive开始时是被修改了的，如果NPC中途死亡，则光靠Revive端是改不回来的，那么该NPC的敌友信息就是错误的
net.Receive("AnimRag_Reviv_T_Death_NPCRelation_sTc", function()
	net.Start("AnimRag_Reviv_T_Death_NPCRelation_cTs")
		net.WriteInt(net.ReadInt(32), 32)		--该NPC
		net.WriteTable(net.ReadTable()) 		--该NPC对所有PLY的敌友信息
		net.WriteTable(net.ReadTable())			--该NPC对所有NPC的敌友信息
	net.SendToServer()
end)


----------------------------------------------------------------------------------------
--在Revive端，当这个Ragdoll正被谁救起时（友军、玩家、或是自活），告诉Crawl端，不要爬行了
net.Receive("AnimRag_Reviv_T_Crawl_PausesCrawl_sTc", function()
	net.Start("AnimRag_Reviv_T_Crawl_PausesCrawl_cTs")
		net.WriteInt(net.ReadInt(32), 32) 		--需要让Crawl端停止crawl的Ragdoll
	net.SendToServer()
end)


----------------------------------------------------------------------------------------
--在Revive端，当这个Ragdoll没能被成功救起时，告诉Crawl端，恢复爬行
net.Receive("AnimRag_Reviv_T_Crawl_ResumeCrawl_sTc", function()
	net.Start("AnimRag_Reviv_T_Crawl_ResumeCrawl_cTs")
		net.WriteInt(net.ReadInt(32), 32) 		--需要让Crawl端恢复crawl的Ragdoll
	net.SendToServer()
end)