

----------------------------------------------------------------------------------------
--Death Aniamtion
CVAR_ARag_enab_d 		= CreateConVar("ARag_enab_d", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable", 0, 1)					--（0/1）是否启用死亡动画
CVAR_ARag_odds_d 		= CreateConVar("ARag_odds_d", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "death_chance", 0, 1)			--（0~1）死亡动画的概率
CVAR_ARag_headshot 		= CreateConVar("ARag_headshot", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "headshot", 0, 1)				--（0/1）是否爆头阻止爬行动画
CVAR_ARag_natural 		= CreateConVar("ARag_natural", 2, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "death_natural", 1, 3)			--（1/3）死亡动画的自然程度
CVAR_ARag_nobackshot 	= CreateConVar("ARag_nobackshot", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "backshot", 0, 1)			--（0/1）是否禁用backshot（因为判定有点迷）


----------------------------------------------------------------------------------------
--Crawl Animation
--是否允许爬行相关
CVAR_ARag_enab_c 		= CreateConVar("ARag_enab_c", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable", 0, 1)					--（0/1）是否启用爬行动画
CVAR_ARag_odds_c 		= CreateConVar("ARag_odds_c", 0.6, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "crawl_chance", 0, 1)			--（0~1）爬行动画的概率
CVAR_ARag_odds_c_repeat = CreateConVar("ARag_odds_c_repeat", 0.6, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "crawl_chance2", 0, 1)	--（0~1）爬行动画重复的概率
CVAR_ARag_odds_hp 		= CreateConVar("ARag_odds_c_hp", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "crawl_chance_hp", 0, 1)		--（0/1）是否根据剩余生命值调整爬行动画的概率
CVAR_ARag_delay_min 	= CreateConVar("ARag_delay_min", 4, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "delaymin")					--（NUM）等待这段时间后再开始爬行动画（min）
CVAR_ARag_delay_max 	= CreateConVar("ARag_delay_max", 8, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "delaymax")					--（NUM）等待这段时间后再开始爬行动画（max）
--爬离敌人相关
CVAR_ARag_avoid_p 		= CreateConVar("ARag_avoid_p", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "avoidp", 0, 1)				--（0/1）是否爬行时躲开Player
CVAR_ARag_avoid_e 		= CreateConVar("ARag_avoid_e", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "avoide", 0, 1)				--（0/1）是否爬行时躲开Hostile
CVAR_ARag_avoid_dist 	= CreateConVar("ARag_avoid_dist", 100, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "avoiddist")				--（NUM）距离多近时才会躲开
--其它
CVAR_ARag_random 		= CreateConVar("ARag_random", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "random", 0, 1)					--（0/1）是否让爬行动画更随机些
CVAR_ARag_ply_allycrawl = CreateConVar("ARag_ply_allycrawl", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "mustcrawl", 0, 1)		--（0/1）是否让玩家的友军爬行的概率为1，这样当友军死后就一定能复活友军了


----------------------------------------------------------------------------------------
--Revive Animation
--是否允许复活相关
CVAR_ARag_enab_ally_r 	= CreateConVar("ARag_enab_ally_r", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "ally_revive", 0, 1)		--（0/1）是否允许NPC的友军前去复活该NPC
CVAR_ARag_enab_self_r 	= CreateConVar("ARag_enab_self_r", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable_selfrevive", 0, 1)	--（0/1）是否允许NPC自活
--复活后的NPC/PLY相关
CVAR_ARag_r_hp_portion 	= CreateConVar("ARag_r_hp_portion", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "newhp_value", 0, 1)		--（0/1）是否将复活NPC的Hp降低到原来的特定百分比
CVAR_ARag_r_hp_portion_v= CreateConVar("ARag_r_hp_portion_v", 0.5, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "newhp_value_v", 0, 1)--（0~1）将复活NPC的Hp降低到原来的百分之多少，如果为1，则Hp不变
CVAR_ARag_r_hp_portion_p= CreateConVar("ARag_r_hp_portion_p", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "newhp_value_p", 0, 1)	--（0/1）是否将复活PLY的Hp降低到原来的特定百分比
CVAR_ARag_r_hp_inherit 	= CreateConVar("ARag_r_hp_inherit", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "inherit_hp", 0, 1)		--（0/1）是否继承Ragdoll的生命值作为复活NPC的生命值（与上边的辣个互斥）
CVAR_ARag_r_hp_inherit_p= CreateConVar("ARag_r_hp_inherit_p", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "inherit_hp_ply", 0, 1)	--（0/1）是否继承Ragdoll的生命值作为复活PLY的生命值（与上边的辣个互斥）
CVAR_ARag_no_2nd_crawl 	= CreateConVar("ARag_no_2nd_crawl", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "no2ndcrawl", 0, 1)		--（0/1）是否让NPC复活后再死时，就不再crawl了
CVAR_ARag_no_2nd_crawl_p= CreateConVar("ARag_no_2nd_crawl_p", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "no2ndcrawl_ply", 0, 1)	--（0/1）是否让PLY复活后再死时，就不再crawl了
--玩家复活相关（在Client端）
--玩家复活HUD相关（在Client端）


----------------------------------------------------------------------------------------
--Player Function
CVAR_ARag_player_1 		= CreateConVar("ARag_player_1", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "playeranim1", 0, 1)			--（0/1）玩家死亡的方式1（用于多人游戏）
CVAR_ARag_player_2 		= CreateConVar("ARag_player_2", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "playeranim2", 0, 1)			--（0/1）玩家死亡的方式2（用于单人游戏）
CVAR_ARag_player_crawl	= CreateConVar("ARag_player_crawl", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "playeranimc", 0, 1)		--（0/1）是否允许玩家爬行动画
CVAR_ARag_player_crawl_c= CreateConVar("ARag_player_crawl_c", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "playeranimc2", 0, 1)	--（0/1）是否允许玩家使用NPC的爬行动画概率
--玩家死亡视角相关（在Client端）


----------------------------------------------------------------------------------------
--Other Function
--其它
CVAR_ARag_female 		= CreateConVar("ARag_female", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "female", 0, 1)					--（0/1）使用经过微调的女性动作（调得并不是很好）
CVAR_ARag_zombie 		= CreateConVar("ARag_zombie", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "zombie", 0, 1)					--（0/1）是否允许僵尸死亡动画
CVAR_ARag_zombie_crawl	= CreateConVar("ARag_zombie_crawl", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "zombie_crawl", 0, 1)		--（0/1）是否允许僵尸爬行动画
CVAR_ARag_clean_e 		= CreateConVar("ARag_clean_e", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "cleanup_e", 0, 1)				--（0/1）是否允许清理Ragdoll
CVAR_ARag_clean 		= CreateConVar("ARag_clean", 30, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "cleanup")						--（NUM）开始清理Ragdoll的数量阈值
CVAR_ARag_finger 		= CreateConVar("ARag_finger", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "fingerpose", 0, 1)				--（0/1）是否允许手指动画
CVAR_ARag_scalerag 		= CreateConVar("ARag_scalerag", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "scaleragdoll", 0, 1)			--（0/1）是否允许缩放AnimRag以自适应Ragdoll
--血迹相关
CVAR_ARag_blood 		= CreateConVar("ARag_blood", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "blood", 0, 1)					--（0/1）是否启用爬行时留下血迹
CVAR_ARag_blood_usetime = CreateConVar("ARag_blood_usetime", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "blood2", 0, 1)			--（0/1）是否使用 固定时间 还是 固定距离 作为血迹的产生间隔
CVAR_ARag_blood_time 	= CreateConVar("ARag_blood_time", 0.3, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "blood3")					--（NUM）设置固定时间
CVAR_ARag_blood_dist 	= CreateConVar("ARag_blood_dist", 10, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "blood4")					--（NUM）设置固定距离
--Debug
CVAR_ARag_healthbar 	= CreateConVar("ARag_healthbar", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "drawhp", 0, 1)				--（0/1）是否在NPC或Ragdoll头顶显示其生命值，用来Debug


----------------------------------------------------------------------------------------
--Overkill Stuff
--Death Aniamtion Overkill
CVAR_OK_Fix_Enable_d 	= CreateConVar("ARag_overkill_fix_enable_d", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "awwww1", 0, 1)
CVAR_OK_Fix_Value_d  	= CreateConVar("ARag_overkill_fix_value_d", 50, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "bwwww1")
CVAR_OK_Max_Enable_d 	= CreateConVar("ARag_overkill_max_enable_d", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "cwwww1", 0, 1)
CVAR_OK_Max_Value_d  	= CreateConVar("ARag_overkill_max_value_d", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "dwwww1")

--Crawl Aniamtion Overkill
CVAR_OK_Fix_Enable_c 	= CreateConVar("ARag_overkill_fix_enable_c", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "awwww2", 0, 1)
CVAR_OK_Fix_Value_c  	= CreateConVar("ARag_overkill_fix_value_c", 50, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "bwwww2")
CVAR_OK_Max_Enable_c 	= CreateConVar("ARag_overkill_max_enable_c", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "cwwww2", 0, 1)
CVAR_OK_Max_Value_c  	= CreateConVar("ARag_overkill_max_value_c", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "dwwww2")
CVAR_OK_Inherit_Hp		= CreateConVar("ARag_overkill_inherit_hp", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "ewwww2", 0, 1)

--These Will Prevent Ragdoll From Crawling
CVAR_OK_Overflow_enable = CreateConVar("ARag_overkill_overflow_enable", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "awwww3", 0, 1)
CVAR_OK_Overflow_value	= CreateConVar("ARag_overkill_overflow_value", 0.5, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "bwwww3")

--Crush Damage
CVAR_OK_CrushDmg_Scale 	= CreateConVar("ARag_overkill_crush_damage", 0.1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "awwww3", 0, 1)