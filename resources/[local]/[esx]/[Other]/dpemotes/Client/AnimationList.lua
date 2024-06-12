DP = {}

DP.Expressions = {
   ["Angry"] = {"Expression", "mood_angry_1"},
   ["Drunk"] = {"Expression", "mood_drunk_1"},
   ["Dumb"] = {"Expression", "pose_injured_1"},
   ["Electrocuted"] = {"Expression", "electrocuted_1"},
   ["Grumpy"] = {"Expression", "effort_1"},
   ["Grumpy2"] = {"Expression", "mood_drivefast_1"},
   ["Grumpy3"] = {"Expression", "pose_angry_1"},
   ["Happy"] = {"Expression", "mood_happy_1"},
   ["Injured"] = {"Expression", "mood_injured_1"},
   ["Joyful"] = {"Expression", "mood_dancing_low_1"},
   ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
   ["Never Blink"] = {"Expression", "pose_normal_1"},
   ["One Eye"] = {"Expression", "pose_aiming_1"},
   ["Shocked"] = {"Expression", "shocked_1"},
   ["Shocked2"] = {"Expression", "shocked_2"},
   ["Sleeping"] = {"Expression", "mood_sleeping_1"},
   ["Sleeping2"] = {"Expression", "dead_1"},
   ["Sleeping3"] = {"Expression", "dead_2"},
   ["Smug"] = {"Expression", "mood_smug_1"},
   ["Speculative"] = {"Expression", "mood_aiming_1"},
   ["Stressed"] = {"Expression", "mood_stressed_1"},
   ["Sulking"] = {"Expression", "mood_sulk_1"},
   ["Weird"] = {"Expression", "effort_2"},
   ["Weird2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Armored"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Brave"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual2"] = {"move_m@casual@b"},
  ["Casual3"] = {"move_m@casual@c"},
  ["Casual4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Cop"] = {"move_m@business@a"},
  ["Cop2"] = {"move_m@business@b"},
  ["Cop3"] = {"move_m@business@c"},
  ["Default Female"] = {"move_f@multiplayer"},
  ["Default Male"] = {"move_m@multiplayer"},
  ["Drunk"] = {"move_m@drunk@a"},
  ["Drunk"] = {"move_m@drunk@slightlydrunk"},
  ["Drunk2"] = {"move_m@buzzed"},
  ["Drunk3"] = {"move_m@drunk@verydrunk"},
  ["Femme"] = {"move_f@femme@"},
  ["Fire"] = {"move_characters@franklin@fire"},
  ["Fire2"] = {"move_characters@michael@fire"},
  ["Fire3"] = {"move_m@fire"},
  ["Flee"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Guard"] = {"move_m@prison_gaurd"},
  ["Handcuffs"] = {"move_m@prisoner_cuffed"},
  ["Heels"] = {"move_f@heels@c"},
  ["Heels2"] = {"move_f@heels@d"},
  ["Hiking"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Hurry"] = {"move_f@hurry@a"},
  ["Janitor"] = {"move_p_m_zero_janitor"},
  ["Janitor2"] = {"move_p_m_zero_slow"},
  ["Jog"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester2"] = {"move_lester_caneup"},
  ["Maneater"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Money"] = {"move_m@money"},
  ["Muscle"] = {"move_m@muscle@a"},
  ["Posh"] = {"move_m@posh@"},
  ["Posh2"] = {"move_f@posh@"},
  ["Quick"] = {"move_m@quick"},
  ["Runner"] = {"female_fast_runner"},
  ["Sad"] = {"move_m@sad@a"},
  ["Sassy"] = {"move_m@sassy"},
  ["Sassy2"] = {"move_f@sassy"},
  ["Scared"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Shady"] = {"move_m@shadyped@a"},
  ["Slow"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Tough"] = {"move_m@tough_guy@"},
  ["Tough2"] = {"move_f@tough_guy@"},
--  ["Trash"] = {"clipset@move@trash_fast_turn"},
 -- ["Trash2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Wide"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.

   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "hug", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["Hugnew"] = {"misscarsteal2chad_goodbye", "chad_armsaround_chad", "Hugnew", "Hugnew2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.35,
       SyncOffsetX = -0.04
   }},
   ["Hugnew2"] = {"misscarsteal2chad_goodbye", "chad_armsaround_girl", "Hugnew2", "Hugnew", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.35,
       SyncOffsetX = -0.04
   }},
   ["Hugnew3"] = {"misscarsteal2chad_goodbye", "chad_idle_chad", "Hugnew3", "Hugnew4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.70,
       SyncOffsetX = -0.15
   }},
   ["Hugnew4"] = {"misscarsteal2chad_goodbye", "chad_idle_girl", "Hugnew4", "Hugnew3", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.70,
       SyncOffsetX = -0.15
   }},
   ["Kiss"] = {"hs3_ext-20", "cs_lestercrest_3_dual-20", "Kiss", "Kiss2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08,
   }},
   ["Kiss2"] = {"hs3_ext-20", "csb_georginacheng_dual-20", "Kiss 2", "Kiss", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08
   }},
   ["Kiss3"] = {"hs3_ext-19", "cs_lestercrest_3_dual-19", "Kiss 3", "Kiss4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08,
   }},
   ["Kiss4"] = {"hs3_ext-19", "csb_georginacheng_dual-19", "Kiss 4", "Kiss3", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "hug2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
--    ["Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Blowjob", "Blowjob2", AnimationOptions =
--    {
--        EmoteMoving = false,
--        EmoteDuration = 20000,
--        SyncOffsetFront = 0.13,
--        SyncOffsetX = -0.02,
       
--    }},
--    ["Blowjob2"] = {"misscarsteal2pimpsex", "pimpsex_pimp", "Blowjob 2", "Blowjob", AnimationOptions =
--    {
--        EmoteMoving = false,
--        EmoteDuration = 20000,
--        SyncOffsetFront = 0.53,
--        SyncOffsetX = -0.02,
       
--    }},

--    ["Sex"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Sex", "Sex2", AnimationOptions =
--    {
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53
--    }},
   
--    ["Sex2"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Sex2", "Sex", AnimationOptions =
--    {
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53
--    }},

  --[[ ["sex3"] = {"random@drunk_driver_2", "cardrunksex_loop_m", "sex3", "sex4", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = -0.40,
       SyncOffsetX = -0.50,
   }},
   ["sex4"] = {"random@drunk_driver_2", "cardrunksex_loop_f", "sex4", "sex3", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53
   }},]]

--    ["Doggy"] = {"rcmpaparazzo_2", "shag_action_a", "Doggy", "Doggy2", AnimationOptions =
--    {
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53,
--        --HeadingOffset = 0.0,
--    }},
--    ["Doggy2"] = {"rcmpaparazzo_2", "shag_action_poppy", "Doggy2", "Doggy", AnimationOptions =
--    {
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53,
--        HeadingOffset = 0.0,
--    }},

--    ["joinhand"] = {"timetable@trevor@ig_1", "ig_1_thedesertissobeautiful_trevor", "joinhand", "joinhand2", AnimationOptions =
--    {
--        EmoteMoving = false,
--        EmoteLoop = true,
--        SyncNoOffsetFront = true,
--        --SyncOffsetFront = 0.00,
--        SyncOffsetY = -0.65,
--        SyncOffsetX = 0.55,
--        HeadingOffset = 0.0,
--    }},
--    ["joinhand2"] = {"timetable@trevor@ig_1", "ig_1_thedesertissobeautiful_patricia", "joinhand2", "joinhand", AnimationOptions =
--    {
--        EmoteMoving = true,
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53
--    }},

  --[[ ["missace"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_trevor", "missace", "missace2", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.80,
       SyncOffsetX = -0.83,
       HeadingOffset = 0.0,
   }},
   ["missace2"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_floyd", "missace2", "missace", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53,
       
   }},]]
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   
   ["give"] = {"mp_common", "givetake1_a", "Give", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Give 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Baseball Throw", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Stickup Scared", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Punch", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Punched", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Headbutted", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Slap 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"},
}

DP.Dances = {
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow5"] = {"misslamar1leadinout", "denise_idle_d", "Dance Slow 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance Silly 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew1"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance New 1", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew2"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon", "Dance New 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew3"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_d_blamadon", "Dance New 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew4"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_11_v1_male^1", "Dance New 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew5"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "hi_dance_facedj_09_v2_male^5", "Dance New 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew6"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_15_v2_male^2", "Dance New 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew7"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "mi_dance_prop_15_v1_male^1", "Dance New 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew8"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^1", "Dance New 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew9"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^2", "Dance New 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew10"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^3", "Dance New 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew11"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^4", "Dance New 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew12"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^5", "Dance New 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew13"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^6", "Dance New 13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew14"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^1", "Dance New 14", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew15"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^2", "Dance New 15", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew16"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^3", "Dance New 16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew17"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^4", "Dance New 17", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew18"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^5", "Dance New 18", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew19"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_a_dixon", "Dance New 19", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew20"] = {"anim@amb@nightclub@djs@solomun@", "sol_trans_out_to_rt_a_sol", "Dance New 20", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew21"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^1", "Dance New 21", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew22"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^2", "Dance New 22", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew23"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^3", "Dance New 23", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew24"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^4", "Dance New 24", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew25"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^5", "Dance New 25", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew26"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^6", "Dance New 26", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew27"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^1", "Dance New 27", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew28"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^2", "Dance New 28", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew29"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^3", "Dance New 29", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew30"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^4", "Dance New 30", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew31"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^5", "Dance New 31", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew32"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^6", "Dance New 32", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew33"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^2", "Dance New 33", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew34"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^3", "Dance New 34", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew35"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^4", "Dance New 35", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew36"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^5", "Dance New 36", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew37"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^6", "Dance New 37", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew38"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^1", "Dance New 38", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew39"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^2", "Dance New 39", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew40"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^3", "Dance New 40", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew41"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^4", "Dance New 41", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew42"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^5", "Dance New 42", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew43"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^6", "Dance New 43", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew44"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^1", "Dance New 44", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew45"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^2", "Dance New 45", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew46"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^3", "Dance New 46", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew47"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^4", "Dance New 47", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew48"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^5", "Dance New 48", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew49"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^6", "Dance New 49", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew50"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^1", "Dance New 50", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew51"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^2", "Dance New 51", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew52"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^3", "Dance New 52", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew53"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^4", "Dance New 53", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew54"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^5", "Dance New 54", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew55"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^6", "Dance New 55", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew56"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^1", "Dance New 56", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew57"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^2", "Dance New 57", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew58"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^3", "Dance New 58", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew59"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^4", "Dance New 59", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew60"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^5", "Dance New 60", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew61"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^6", "Dance New 61", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew62"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^1", "Dance New 62", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew63"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^2", "Dance New 63", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew64"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^3", "Dance New 64", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew65"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^4", "Dance New 65", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew66"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^5", "Dance New 66", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew67"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^6", "Dance New 67", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew68"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^1", "Dance New 68", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew69"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^2", "Dance New 69", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew70"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^3", "Dance New 70", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew71"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^4", "Dance New 71", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew72"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^5", "Dance New 72", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew73"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^6", "Dance New 73", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew74"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^1", "Dance New 74", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew75"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^2", "Dance New 75", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew76"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^3", "Dance New 76", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew77"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^4", "Dance New 77", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew78"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^5", "Dance New 78", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew79"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^6", "Dance New 79", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew80"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^1", "Dance New 80", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew81"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^2", "Dance New 81", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew82"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^3", "Dance New 82", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew83"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^4", "Dance New 83", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew84"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^5", "Dance New 84", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew85"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^6", "Dance New 85", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew86"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^1", "Dance New 86", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew87"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^2", "Dance New 87", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew88"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^3", "Dance New 88", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew89"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^4", "Dance New 89", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew90"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^5", "Dance New 90", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew91"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^6", "Dance New 91", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew92"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^1", "Dance New 92", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew93"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^2", "Dance New 93", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew94"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^3", "Dance New 94", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew95"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^4", "Dance New 95", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew96"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^5", "Dance New 96", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew97"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^6", "Dance New 97", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew98"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^1", "Dance New 98", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew99"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^2", "Dance New 99", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew100"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^3", "Dance New 100", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew101"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^4", "Dance New 101", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew102"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^5", "Dance New 102", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew103"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^6", "Dance New 103", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
   ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Beast", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Cloudgaze", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Cloudgaze 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["prone"] = {"missfbi3_sniping", "prone_dave", "Prone", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Pullover", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   --789store

   ["v2socute1"] = {"789@v2socute1", "v2socute1", "789Store So Cute 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["v2socute2"] = {"789@v2socute2", "v2socute2", "789Store So Cute 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["v2socute3"] = {"789@v2socute3", "v2socute3", "789Store So Cute 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["v2socute4"] = {"789@v2socute4", "v2socute4", "789Store So Cute 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute5"] = {"789@v2socute5", "v2socute5", "789Store So Cute 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute6"] = {"789@v2socute6", "v2socute6", "789Store So Cute 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute7"] = {"789@v2socute7", "v2socute7", "789Store So Cute 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute8"] = {"789@v2socute8", "v2socute8", "789Store So Cute 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute9"] = {"789@v2socute9", "v2socute9", "789Store So Cute 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["v2socute10"] = {"789@v2socute10", "v2socute10", "789Store So Cute 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["luxury1"] = {"789@luxury1", "luxury1", "789Store Luxury1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury10"] = {"789@luxury10", "luxury10", "789Store Luxury10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury2"] = {"789@luxury2", "luxury2", "789Store Luxury2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury3"] = {"789@luxury3", "luxury3", "789Store Luxury3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury4"] = {"789@luxury4", "luxury4", "789Store Luxury4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury5"] = {"789@luxury5", "luxury5", "789Store Luxury5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury6"] = {"789@luxury6", "luxury6", "789Store Luxury6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury7"] = {"789@luxury7", "luxury7", "789Store Luxury7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury8"] = {"789@luxury8", "luxury8", "789Store Luxury8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["luxury9"] = {"789@luxury9", "luxury9", "789Store Luxury9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["sea10"] = {"789@sea10", "sea10", "789Store Sea10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea4"] = {"789@sea4", "sea4", "789Store Sea4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea5"] = {"789@sea5", "sea5", "789Store Sea5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea6"] = {"789@sea6", "sea6", "789Store Sea6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea7"] = {"789@sea7", "sea7", "789Store Sea7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea8"] = {"789@sea8", "sea8", "789Store Sea8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sea9"] = {"789@sea9", "sea9", "789Store Sea9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["happy1"] = {"789@happy1", "happy1", "789Store Happy1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy10"] = {"789@happy10", "happy10", "789Store Happy10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy2"] = {"789@happy2", "happy2", "789Store Happy2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy3"] = {"789@happy3", "happy3", "789Store Happy3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy4"] = {"789@happy4", "happy4", "789Store Happy4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy5"] = {"789@happy5", "happy5", "789Store Happy5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy6"] = {"789@happy6", "happy6", "789Store Happy6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy7"] = {"789@happy7", "happy7", "789Store Happy7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy8"] = {"789@happy8", "happy8", "789Store Happy8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["happy9"] = {"789@happy9", "happy9", "789Store Happy9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["jelly1"] = {"789@jelly1", "jelly1", "789Store Jelly1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly10"] = {"789@jelly10", "jelly10", "789Store Jelly10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly2"] = {"789@jelly2", "jelly2", "789Store Jelly2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly3"] = {"789@jelly3", "jelly3", "789Store Jelly3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly4"] = {"789@jelly4", "jelly4", "789Store Jelly4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly5"] = {"789@jelly5", "jelly5", "789Store Jelly5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly7"] = {"789@jelly7", "jelly7", "789Store Jelly7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly8"] = {"789@jelly8", "jelly8", "789Store Jelly8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jelly9"] = {"789@jelly9", "jelly9", "789Store Jelly9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["seedar1"] = {"789@seedar1", "seedar1", "789Store Seedar1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar10"] = {"789@seedar10", "seedar10", "789Store Seedar10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar2"] = {"789@seedar2", "seedar2", "789Store Seedar2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar3"] = {"789@seedar3", "seedar3", "789Store Seedar3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar4"] = {"789@seedar4", "seedar4", "789Store Seedar4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar5"] = {"789@seedar5", "seedar5", "789Store Seedar5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar6"] = {"789@seedar6", "seedar6", "789Store Seedar6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar7"] = {"789@seedar7", "seedar7", "789Store Seedar7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar8"] = {"789@seedar8", "seedar8", "789Store Seedar8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["seedar9"] = {"789@seedar9", "seedar9", "789Store Seedar9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["x12"] = {"789@x12", "x12", "789Store X12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x13"] = {"789@x13", "x13", "789Store X13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x14"] = {"789@x14", "x14", "789Store X14", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x15"] = {"789@x15", "x15", "789Store X15", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x16"] = {"789@x16", "x16", "789Store X16", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x17"] = {"789@x17", "x17", "789Store X17", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["x18"] = {"789@x18", "x18", "789Store X18", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},


   ["songkransingle1"] = {"789@songkransingle1", "songkransingle1", "789Store Songkransingle1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["songkransingle2"] = {"789@songkransingle2", "songkransingle2", "789Store Songkransingle2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["songkransingle3"] = {"789@songkransingle3", "songkransingle3", "789Store Songkransingle3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["songkransingle4"] = {"789@songkransingle4", "songkransingle4", "789Store Songkransingle4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["songkransingle5"] = {"789@songkransingle5", "songkransingle5", "789Store Songkransingle5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["songkransingle6"] = {"789@songkransingle6", "songkransingle6", "789Store Songkransingle6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["sitcute1"] = {"789@sitcute1", "sitcute1", "789Store Sitcute1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute2"] = {"789@sitcute2", "sitcute2", "789Store Sitcute2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute3"] = {"789@sitcute3", "sitcute3", "789Store Sitcute3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute4"] = {"789@sitcute4", "sitcute4", "789Store Sitcute4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute5"] = {"789@sitcute5", "sitcute5", "789Store Sitcute5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute6"] = {"789@sitcute6", "sitcute6", "789Store Sitcute6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sitcute7"] = {"789@sitcute7", "sitcute7", "789Store Sitcute7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["sky1"] = {"789@sky1", "sky1", "789Store Sky1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sky2"] = {"789@sky2", "sky2", "789Store Sky2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sky3"] = {"789@sky3", "sky3", "789Store Sky3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sky4"] = {"789@sky4", "sky4", "789Store Sky4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sky5"] = {"789@sky5", "sky5", "789Store Sky5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["10_y2k"] = {"789@10_y2k", "10_y2k", "789Store y2k 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["1_y2k"] = {"789@1_y2k", "1_y2k", "789Store y2k 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["2_y2k"] = {"789@2_y2k", "2_y2k", "789Store y2k 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["3_y2k"] = {"789@3_y2k", "3_y2k", "789Store y2k 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["4_y2k"] = {"789@4_y2k", "4_y2k", "789Store y2k 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["5_y2k"] = {"789@5_y2k", "5_y2k", "789Store y2k 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["6_y2k"] = {"789@6_y2k", "6_y2k", "789Store y2k 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["7_y2k"] = {"789@7_y2k", "7_y2k", "789Store y2k 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["9_y2k"] = {"789@9_y2k", "9_y2k", "789Store y2k 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["babyq1"] = {"789@babyq1", "babyq1", "789Store Babyq1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq2"] = {"789@babyq2", "babyq2", "789Store Babyq2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq3"] = {"789@babyq3", "babyq3", "789Store Babyq3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq4"] = {"789@babyq4", "babyq4", "789Store Babyq4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq5"] = {"789@babyq5", "babyq5", "789Store Babyq5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq6"] = {"789@babyq6", "babyq6", "789Store Babyq6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyq7"] = {"789@babyq7", "babyq7", "789Store Babyq7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["badboy1"] = {"789@badboy1", "badboy1", "789Store Badboy1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy2"] = {"789@badboy2", "badboy2", "789Store Badboy2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy3"] = {"789@badboy3", "badboy3", "789Store Badboy3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy4"] = {"789@badboy4", "badboy4", "789Store Badboy4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy5"] = {"789@badboy5", "badboy5", "789Store Badboy5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy6"] = {"789@badboy6", "badboy6", "789Store Badboy6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy7"] = {"789@badboy7", "badboy7", "789Store Badboy7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["badboy8"] = {"789@badboy8", "badboy8", "789Store Badboy8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["ray@nim1"] = {"ray@nim1", "nim1", "789Store Ray Nim1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim10"] = {"ray@nim10", "nim10", "789Store Ray Nim10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim2"] = {"ray@nim2", "nim2", "789Store Ray Nim2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim3"] = {"ray@nim3", "nim3", "789Store Ray Nim3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim4"] = {"ray@nim4", "nim4", "789Store Ray Nim4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim5"] = {"ray@nim5", "nim5", "789Store Ray Nim5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim6"] = {"ray@nim6", "nim6", "789Store Ray Nim6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim7"] = {"ray@nim7", "nim7", "789Store Ray Nim7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim8"] = {"ray@nim8", "nim8", "789Store Ray Nim8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@nim9"] = {"ray@nim9", "nim9", "789Store Ray Nim9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["ray@a1"] = {"ray@a1", "a1", "789Store Ray A1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a10"] = {"ray@a10", "a10", "789Store Ray A10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a2"] = {"ray@a2", "a2", "789Store Ray A2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a3"] = {"ray@a3", "a3", "789Store Ray A3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a4"] = {"ray@a4", "a4", "789Store Ray A4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a5"] = {"ray@a5", "a5", "789Store Ray A5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a6"] = {"ray@a6", "a6", "789Store Ray A6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a7"] = {"ray@a7", "a7", "789Store Ray A7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a8"] = {"ray@a8", "a8", "789Store Ray A8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@a9"] = {"ray@a9", "a9", "789Store Ray A9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["ray@solo1"] = {"ray@solo1", "solo1", "789Store Ray Solo1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo10"] = {"ray@solo10", "solo10", "789Store Ray Solo10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo2"] = {"ray@solo2", "solo2", "789Store Ray Solo2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo3"] = {"ray@solo3", "solo3", "789Store Ray Solo3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo4"] = {"ray@solo4", "solo4", "789Store Ray Solo4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo5"] = {"ray@solo5", "solo5", "789Store Ray Solo5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo6"] = {"ray@solo6", "solo6", "789Store Ray Solo6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo7"] = {"ray@solo7", "solo7", "789Store Ray Solo7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo8"] = {"ray@solo8", "solo8", "789Store Ray Solo8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ray@solo9"] = {"ray@solo9", "solo9", "789Store Ray Solo9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["cuteshot"] = {"789@cuteshot", "cuteshot", "789Store Cuteshot", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot10"] = {"789@cuteshot10", "cuteshot10", "789Store Cuteshot10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot2"] = {"789@cuteshot2", "cuteshot2", "789Store Cuteshot2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot3"] = {"789@cuteshot3", "cuteshot3", "789Store Cuteshot3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot4"] = {"789@cuteshot4", "cuteshot4", "789Store Cuteshot4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot5"] = {"789@cuteshot5", "cuteshot5", "789Store Cuteshot5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot6"] = {"789@cuteshot6", "cuteshot6", "789Store Cuteshot6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot7"] = {"789@cuteshot7", "cuteshot7", "789Store Cuteshot7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot8"] = {"789@cuteshot8", "cuteshot8", "789Store Cuteshot8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cuteshot9"] = {"789@cuteshot9", "cuteshot9", "789Store Cuteshot9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["m1"] = {"789@m1", "m1", "789Store M1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m10"] = {"789@m10", "m10", "789Store M10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m11"] = {"789@m11", "m11", "789Store M11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m12"] = {"789@m12", "m12", "789Store M12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m13"] = {"789@m13", "m13", "789Store M13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m2"] = {"789@m2", "m2", "789Store M2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m3"] = {"789@m3", "m3", "789Store M3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m4"] = {"789@m4", "m4", "789Store M4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m5"] = {"789@m5", "m5", "789Store M5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m6"] = {"789@m6", "m6", "789Store M6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m7"] = {"789@m7", "m7", "789Store M7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m8"] = {"789@m8", "m8", "789Store M8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["m9"] = {"789@m9", "m9", "789Store M9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["babysircute1"] = {"789@babysircute1", "babysircute1", "789Store Babysircute1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute2"] = {"789@babysircute2", "babysircute2", "789Store Babysircute2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute3"] = {"789@babysircute3", "babysircute3", "789Store Babysircute3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute4"] = {"789@babysircute4", "babysircute4", "789Store Babysircute4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute5"] = {"789@babysircute5", "babysircute5", "789Store Babysircute5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute6"] = {"789@babysircute6", "babysircute6", "789Store Babysircute6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babysircute7"] = {"789@babysircute7", "babysircute7", "789Store Babysircute7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   
   ["cookie1"] = {"789@cookie1", "cookie1", "789Store Cookie1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie10"] = {"789@cookie10", "cookie10", "789Store Cookie10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie2"] = {"789@cookie2", "cookie2", "789Store Cookie2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie3"] = {"789@cookie3", "cookie3", "789Store Cookie3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie4"] = {"789@cookie4", "cookie4", "789Store Cookie4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie5"] = {"789@cookie5", "cookie5", "789Store Cookie5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie6"] = {"789@cookie6", "cookie6", "789Store Cookie6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie7"] = {"789@cookie7", "cookie7", "789Store Cookie7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie8"] = {"789@cookie8", "cookie8", "789Store Cookie8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cookie9"] = {"789@cookie9", "cookie9", "789Store Cookie9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["gamergirls_1"] = {"789@gamergirls_1", "gamergirls_1", "789Store Gamergirls 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gamergirls_2"] = {"789@gamergirls_2", "gamergirls_2", "789Store Gamergirls 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gamergirls_3"] = {"789@gamergirls_3", "gamergirls_3", "789Store Gamergirls 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gamergirls_4"] = {"789@gamergirls_4", "gamergirls_4", "789Store Gamergirls 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gamergirls_5"] = {"789@gamergirls_5", "gamergirls_5", "789Store Gamergirls 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["glassespose1"] = {"789@glassespose1", "glassespose1", "789Store Glassespose1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["glassespose2"] = {"789@glassespose2", "glassespose2", "789Store Glassespose2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["glassespose3"] = {"789@glassespose3", "glassespose3", "789Store Glassespose3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["glassespose4"] = {"789@glassespose4", "glassespose4", "789Store Glassespose4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["glassespose5"] = {"789@glassespose5", "glassespose5", "789Store Glassespose5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["incar1"] = {"789@incar1", "incar1", "789Store Incar1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar10"] = {"789@incar10", "incar10", "789Store Incar10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar2"] = {"789@incar2", "incar2", "789Store Incar2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar3"] = {"789@incar3", "incar3", "789Store Incar3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar4"] = {"789@incar4", "incar4", "789Store Incar4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar5"] = {"789@incar5", "incar5", "789Store Incar5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar6"] = {"789@incar6", "incar6", "789Store Incar6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar7"] = {"789@incar7", "incar7", "789Store Incar7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar8"] = {"789@incar8", "incar8", "789Store Incar8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar9"] = {"789@incar9", "incar9", "789Store Incar9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["knowu1"] = {"789@knowu1", "knowu1", "789Store Knowu1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["knowu2"] = {"789@knowu2", "knowu2", "789Store Knowu2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["knowu3"] = {"789@knowu3", "knowu3", "789Store Knowu3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["knowu4"] = {"789@knowu4", "knowu4", "789Store Knowu4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["knowu5"] = {"789@knowu5", "knowu5", "789Store Knowu5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["knowu6"] = {"789@knowu6", "knowu6", "789Store Knowu6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["lovelykid1"] = {"789@lovelykid1", "lovelykid1", "789Store Lovelykid1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid10"] = {"789@lovelykid10", "lovelykid10", "789Store Lovelykid10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid2"] = {"789@lovelykid2", "lovelykid2", "789Store Lovelykid2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid3"] = {"789@lovelykid3", "lovelykid3", "789Store Lovelykid3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid4"] = {"789@lovelykid4", "lovelykid4", "789Store Lovelykid4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid5"] = {"789@lovelykid5", "lovelykid5", "789Store Lovelykid5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid6"] = {"789@lovelykid6", "lovelykid6", "789Store Lovelykid6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid7"] = {"789@lovelykid7", "lovelykid7", "789Store Lovelykid7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid8"] = {"789@lovelykid8", "lovelykid8", "789Store Lovelykid8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lovelykid9"] = {"789@lovelykid9", "lovelykid9", "789Store Lovelykid9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["phalo1"] = {"789@phalo1", "phalo1", "789Store Phalo1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phalo2"] = {"789@phalo2", "phalo2", "789Store Phalo2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phalo3"] = {"789@phalo3", "phalo3", "789Store Phalo3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phalo4"] = {"789@phalo4", "phalo4", "789Store Phalo4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phalo5"] = {"789@phalo5", "phalo5", "789Store Phalo5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["rine1"] = {"789@rine1", "rine1", "789Store Rine1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rine2"] = {"789@rine2", "rine2", "789Store Rine2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rine3"] = {"789@rine3", "rine3", "789Store Rine3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rine4"] = {"789@rine4", "rine4", "789Store Rine4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rine5"] = {"789@rine5", "rine5", "789Store Rine5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rine6"] = {"789@rine6", "rine6", "789Store Rine6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["skypose1"] = {"789@skypose1", "skypose1", "789Store Skypose1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose2"] = {"789@skypose2", "skypose2", "789Store Skypose2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose3"] = {"789@skypose3", "skypose3", "789Store Skypose3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose4"] = {"789@skypose4", "skypose4", "789Store Skypose4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose5"] = {"789@skypose5", "skypose5", "789Store Skypose5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose7"] = {"789@skypose7", "skypose7", "789Store Skypose7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose8"] = {"789@skypose8", "skypose8", "789Store Skypose8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["skypose9"] = {"789@skypose9", "skypose9", "789Store Skypose9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["ss01"] = {"789@ss01", "ss01", "789Store Ss01", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ss02"] = {"789@ss02", "ss02", "789Store Ss02", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ss03"] = {"789@ss03", "ss03", "789Store Ss03", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ss04"] = {"789@ss04", "ss04", "789Store Ss04", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ss05"] = {"789@ss05", "ss05", "789Store Ss05", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["whois1"] = {"789@whois1", "whois1", "789Store Whois1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois10"] = {"789@whois10", "whois10", "789Store Whois10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois2"] = {"789@whois2", "whois2", "789Store Whois2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois3"] = {"789@whois3", "whois3", "789Store Whois3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois4"] = {"789@whois4", "whois4", "789Store Whois4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois5"] = {"789@whois5", "whois5", "789Store Whois5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois6"] = {"789@whois6", "whois6", "789Store Whois6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois7"] = {"789@whois7", "whois7", "789Store Whois7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois8"] = {"789@whois8", "whois8", "789Store Whois8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whois9"] = {"789@whois9", "whois9", "789Store Whois9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["babyqueen@queen01"] = {"babyqueen@queen01", "queen01", "789Store Babyqueen Queen01", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen02"] = {"babyqueen@queen02", "queen02", "789Store Babyqueen Queen02", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen03"] = {"babyqueen@queen03", "queen03", "789Store Babyqueen Queen03", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen04"] = {"babyqueen@queen04", "queen04", "789Store Babyqueen Queen04", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen05"] = {"babyqueen@queen05", "queen05", "789Store Babyqueen Queen05", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen06"] = {"babyqueen@queen06", "queen06", "789Store Babyqueen Queen06", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen07"] = {"babyqueen@queen07", "queen07", "789Store Babyqueen Queen07", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen08"] = {"babyqueen@queen08", "queen08", "789Store Babyqueen Queen08", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen09"] = {"babyqueen@queen09", "queen09", "789Store Babyqueen Queen09", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen10"] = {"babyqueen@queen10", "queen10", "789Store Babyqueen Queen10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen11"] = {"babyqueen@queen11", "queen11", "789Store Babyqueen Queen11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen12"] = {"babyqueen@queen12", "queen12", "789Store Babyqueen Queen12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen13"] = {"babyqueen@queen13", "queen13", "789Store Babyqueen Queen13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen14"] = {"babyqueen@queen14", "queen14", "789Store Babyqueen Queen14", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen15"] = {"babyqueen@queen15", "queen15", "789Store Babyqueen Queen15", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueen@queen16"] = {"babyqueen@queen16", "queen16", "789Store Babyqueen Queen16", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["smooking1"] = {"789@smooking1", "smooking1", "789Store Smooking1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking10"] = {"789@smooking10", "smooking10", "789Store Smooking10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking11"] = {"789@smooking11", "smooking11", "789Store Smooking11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking12"] = {"789@smooking12", "smooking12", "789Store Smooking12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking2"] = {"789@smooking2", "smooking2", "789Store Smooking2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking3"] = {"789@smooking3", "smooking3", "789Store Smooking3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking4"] = {"789@smooking4", "smooking4", "789Store Smooking4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking5"] = {"789@smooking5", "smooking5", "789Store Smooking5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking6"] = {"789@smooking6", "smooking6", "789Store Smooking6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking7"] = {"789@smooking7", "smooking7", "789Store Smooking7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking8"] = {"789@smooking8", "smooking8", "789Store Smooking8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smooking9"] = {"789@smooking9", "smooking9", "789Store Smooking9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yong10"] = {"789@yong10", "yong10", "789Store Yong10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yong6"] = {"789@yong6", "yong6", "789Store Yong6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yong8"] = {"789@yong8", "yong8", "789Store Yong8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yong9"] = {"789@yong9", "yong9", "789Store Yong9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["youg7"] = {"789@youg7", "youg7", "789Store Youg7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["y2k1"] = {"789@y2k1", "y2k1", "789Store Y2k1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k10"] = {"789@y2k10", "y2k10", "789Store Y2k10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k2"] = {"789@y2k2", "y2k2", "789Store Y2k2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k3"] = {"789@y2k3", "y2k3", "789Store Y2k3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k4"] = {"789@y2k4", "y2k4", "789Store Y2k4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k5"] = {"789@y2k5", "y2k5", "789Store Y2k5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k6"] = {"789@y2k6", "y2k6", "789Store Y2k6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k7"] = {"789@y2k7", "y2k7", "789Store Y2k7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k8"] = {"789@y2k8", "y2k8", "789Store Y2k8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["y2k9"] = {"789@y2k9", "y2k9", "789Store Y2k9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789luxury1"] = {"789@luxury1", "luxury1", "789Store Luxury Girl 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury2"] = {"789@luxury2", "luxury2", "789Store Luxury Girl 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury3"] = {"789@luxury3", "luxury3", "789Store Luxury Girl 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury4"] = {"789@luxury4", "luxury4", "789Store Luxury Girl 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury5"] = {"789@luxury5", "luxury5", "789Store Luxury Girl 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury6"] = {"789@luxury6", "luxury6", "789Store Luxury Girl 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury7"] = {"789@luxury7", "luxury7", "789Store Luxury Girl 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury8"] = {"789@luxury8", "luxury8", "789Store Luxury Girl 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury9"] = {"789@luxury9", "luxury9", "789Store Luxury Girl 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury10"] = {"789@luxury10", "luxury10", "789Store Luxury Girl 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury11"] = {"789@luxury11", "luxury11", "789Store Luxury Boy 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury12"] = {"789@luxury12", "luxury12", "789Store Luxury Boy 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury13"] = {"789@luxury13", "luxury13", "789Store Luxury Boy 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury14"] = {"789@luxury14", "luxury14", "789Store Luxury Boy 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury15"] = {"789@luxury15", "luxury15", "789Store Luxury Boy 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury16"] = {"789@luxury16", "luxury16", "789Store Luxury Boy 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},

   
   




   ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synth"},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Argue", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Argue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Blow Kiss 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cop 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Cop 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Crossarms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Crossarms 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Crossarms 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Crossarms 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Crossarms 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ------- Neko emo ------

   ["Nekopiggy"] = {"fos_ep_1_p1-9", "csb_imran_dual-9", "Neko piggy", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew"] = {"fos_ep_1_p0-0", "cs_lazlow_dual-0", "Neko new", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew2"] = {"fos_ep_1_p1-0", "cs_lazlow_dual-0", "Neko new2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew3"] = {"fos_ep_1_p1-0", "csb_imran_dual-0", "Neko new3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew4"] = {"fos_ep_1_p1-1", "cs_lazlow_dual-1", "Neko new4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},

   ["Nekonew5"] = {"fos_ep_1_p1-1", "csb_anita_dual-1", "Neko new5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew6"] = {"fos_ep_1_p1-1", "csb_imran_dual-1", "Neko new6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew7"] = {"fos_ep_1_p5-2", "csb_william_dual-2", "Neko new7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew8"] = {"timetable@trevor@ig_1", "ig_1_therearejustsomemoments_patricia", "Neko new8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew9"] = {"impexp_int_l1-11", "mp_m_waremech_01_dual-11", "Neko new9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew10"] = {"amb@prop_human_seat_computer@male@react_shock", "forward", "Neko new10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonew11"] = {"amb@prop_human_seat_bar@male@elbows_on_bar@idle_b", "idle_d", "Neko new11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonew12"] = {"amb@incar@male@security@idle_a", "idle_a", "Neko new12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekopost4"] = {"mpcas_int-2", "s_m_y_casino_01^1_dual-2", "Neko post4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekohelp"] = {"missheist_agency3aig_19", "ground_call_help", "Neko help", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep3"] = {"missheist_agency3amcs_4b", "crew_dead_crew2", "Neko sleep3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep4"] = {"missheist_jewel", "gassed_npc_customer1", "Neko sleep4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep5"] = {"missheist_jewel", "gassed_npc_customer2", "Neko sleep5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep6"] = {"missheist_jewel", "gassed_npc_customer3", "Neko sleep6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep7"] = {"missheist_jewel", "gassed_npc_customer4", "Nekosleep7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekositpost8"] = {"missheistdockssetup1ig_10@base", "talk_pipe_base_worker1", "Neko sitpost8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekocall"] = {"missheistdockssetup1ig_14", "floyd_ok_now_grab_the_container", "Neko Call", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodrunk4"] = {"missheistpaletopinned", "pinned_against_wall_pro_loop_buddy", "Neko drunk4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekoyoga6"] = {"misslamar1leadinout", "yoga_02_idle_b", "Neko yoga6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekolieabout"] = {"missmic2ig_11", "mic_2_ig_11_a_p_one", "Neko lie about", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekobundle"] = {"missprologueig_2", "idle_on_floor_gaurd", "Neko bundle", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekobundle2"] = {"missprologueig_2", "idle_outside_cuboard_gaurd", "Neko bundle2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekosleep8"] = {"missprologueig_6", "lying_dead_brad", "Neko sleep8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep9"] = {"missprologueig_6", "lying_dead_player0", "Neko sleep9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekorod"] = {"misstrevor1ig_3", "action_b", "Neko rod", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekocheck2"] = {"misstrevor3", "bike_chat_b_loop_1", "Neko check2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekocheck3"] = {"misstvrram_5", "marines_idle_b", "Neko check3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonumb"] = {"mp_arrest_paired", "crook_p1_idle", "Neko numb", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonumb2"] = {"mp_cop_miss", "dazed", "Neko numb2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ANekosawatdee"] = {"fam_4_int_alt1-17", "cs_amandatownley_dual-17", "Neko sawatdee", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["ANekosawatdee2"] = {"fos_ep_1_p1-26", "csb_imran_dual-26", "Neko sawatdee2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

--    ["incar"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_male", "incar", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
--    }},
   
--    ["incar2"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_prostitute", "incar2", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["incar3"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", "incar3", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Neko Sex", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex2"] = {"misscarsteal2pimpsex", "pimpsex_pimp", "Neko Sex2", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex3"] = {"misscarsteal2pimpsex", "pimpsex_punter", "Neko Sex3", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex4"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Neko Sex4", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex5"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Neko Sex5", AnimationOptions =
--    {
--        EmoteLoop = true,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex6"] = {"rcmpaparazzo_2", "shag_action_poppy", "Neko Sex6", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

--    ["Nekosex7"] = {"rcmpaparazzo_2", "shag_action_a", "Neko Sex5", AnimationOptions =
--    {
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},

   ["Nekogivebirth"] = {"mini@cpr@char_a@cpr_str", "cpr_kol", "Neko Give birth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekotiedup"] = {"random@burial", "b_burial", "Neko Tied up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositchair7"] = {"anim@amb@nightclub@smoking@", "blunt_idle_a", "Neko Sit Chair 7", AnimationOptions =
   {    
       Prop = 'p_cs_joint_02',
       PropBone = 28422,
       PropPlacement = {0.0800003, -0.004999998, -0.035, 175.5002, 311.0003, 232.0},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair8"] = {"anim@amb@nightclub@smoking@", "blunt_idle_b", "Neko Sit Chair 8", AnimationOptions =
   {    
       Prop = 'p_cs_joint_02',
       PropBone = 28422,
       PropPlacement = {0.0800003, -0.004999998, -0.035, 175.5002, 311.0003, 232.0},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrink2"] = {"friends@frl@ig_1", "drink_lamar", "Neko Drink 2", AnimationOptions =
   {    
       Prop = 'prop_beer_patriot',
       PropBone = 60309,
       PropPlacement = {-0.03499999, -0.165, -0.015, 436.7987, 412.3998, 177.4},
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},

   ["Nekomc"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_dlg_tonymctony_laz", "Neko MC", AnimationOptions =
   {    
       Prop = 'p_ing_microphonel_01',
       PropBone = 57005,
       PropPlacement = {0.1249999, 0.03, -0.005000002, 87.10002, 149.8, 200.8},
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},


   ["Nekojump1"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_d_player_a", "Neko Jump 1", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump2"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_c_player_a", "Neko Jump 2", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump3"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_b_player_a", "Neko Jump 3", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump4"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_a_player_a", "Neko Jump 4", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekoleanbar5"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 5", AnimationOptions =
   {   
       Prop = 'prop_cs_ciggy_01',
       PropBone = 58867,
       PropPlacement = {0.0599999, 0.005, -0.015, 40.29999, 78.3, 124.1},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoleanbar6"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 6", AnimationOptions =
   {   
       Prop = 'p_cs_joint_02',
       PropBone = 58867,
       PropPlacement = {0.0599999, 0.005, -0.015, 40.29999, 78.3, 124.1},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoleanbar7"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 7", AnimationOptions =
   {   
       Prop = 'prop_cigar_03',
       PropBone = 58867,
       PropPlacement = {0.06499989, 0.015, -0.01, 0.0, 78.3, 299.6001},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositmafia"] = {"safe@michael@ig_3", "cigar_idle_b_michael", "Neko Sit Mafia", AnimationOptions =
   {   
       Prop = 'prop_cigar_03',
       PropBone = 58867,
       PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekosmell2"] = {"safe@trevor@ig_8", "ig_8_huff_gas_player", "NekoSmell 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear"] = {"anim@heists@ornate_bank@hostages@cashier_b@", "flinch_loop_underfire", "Neko Fear", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekowipe"] = {"switch@franklin@cleaning_car", "001946_01_gc_fras_v2_ig_5_base", "Neko Wipe", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},

   ["Nekositchair9"] = {"mini@strip_club@wade@", "leadin_loop_idle_a_stripper_a", "Neko Sit Chair 9", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositmafia2"] = {"mini@strip_club@wade@", "leadin_loop_idle_a_wade", "Neko Sit Mafia 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekocheer2"] = {"mini@triathlon", "male_one_handed_a", "Neko Cheer 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekocheer3"] = {"mini@triathlon", "male_two_handed_a", "Neko Cheer 3", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean6"] = {"missarmenian1leadinoutarm_1_ig_14_leadinout", "leadin_loop", "Neko Lean 6", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrunk"] = {"missbigscore1leadinoutbs_1_int", "leadin_loop_c_trevor", "Neko Drunk", AnimationOptions =
   {   
       Prop = 'prop_wine_rose',
       PropBone = 58867,
       PropPlacement = {0.02499996, -0.009999998, -0.3599998, 172.9002, 183.6, 155.3},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopee2"] = {"missbigscore1switch_trevor_piss", "piss_loop", "Neko Pee 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean7"] = {"misscarsteal1car_1_ext_leadin", "base_driver1", "Neko Lean 7", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopee3"] = {"misscarsteal2peeing", "peeing_loop", "Neko Pee 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekoleanbar8"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Neko Lean Bar 8", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekodapap"] = {"misscarstealfinalecar_5_ig_3", "leanleft_loop", "Neko Dapap", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekocool"] = {"misschinese1leadinoutchi_1_mcs_4", "chi_1_mcs_4_tao_idle_2", "Neko Cool", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean8"] = {"missclothing", "idle_a", "Neko Lean 8", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean9"] = {"missclothing", "idle_b", "Neko Lean 9", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean10"] = {"missclothing", "idle_c", "Neko Lean 10", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekosadly"] = {"missfam4leadinoutmcs2", "tracy_loop", "Neko Sadly", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga2"] = {"missfam5_yoga", "c5_pose", "Neko Yoga 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga3"] = {"missfam5_yoga", "c6_pose", "Neko Yoga 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga4"] = {"missfam5_yoga", "c7_pose", "Neko Yoga 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopost"] = {"missfbi4leadinoutfbi_4_int", "agents_idle_a_andreas", "Neko post", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomonkey"] = {"missfbi5ig_30monkeys", "monkey_a_freakout_loop", "Neko Monkey", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomonkey2"] = {"missfbi5ig_30monkeys", "monkey_c_freakout_loop", "Neko Monkey 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekocry"] = {"missfinale_a_ig_2", "trevor_death_reaction_pt", "Neko Cry", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoreverence"] = {"missfra2", "lamar_base_idle", "Neko Reverence", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopost2"] = {"misshair_shop@barbers", "keeper_base", "Neko Post 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekopost3"] = {"misshair_shop@hair_dressers", "keeper_idle_a", "NekoPost 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoclamber"] = {"missheist_agency3aig_19", "ground_call_help", "Neko Clamber", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekosleep2"] = {"missheist_jewel", "cop_on_floor", "Neko Sleep 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga5"] = {"misslamar1leadinout", "yoga_01_idle", "Neko Yoga 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair10"] = {"misslester1aig_3main", "air_guitar_01_b", "Neko Sit Chair 10", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair11"] = {"misslester1aig_5intro", "boardroom_intro_f_b", "Neko Sit Chair 11", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair12"] = {"misslester1aig_5intro", "boardroom_intro_f_c", "Neko Sit Chair 12", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodig"] = {"missmic1leadinoutmic_1_mcs_2", "_leadin_trevor", "Neko Dig", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekowashface"] = {"missmic2_washing_face", "michael_washing_face", "Neko Wash Face", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekorepent"] = {"misstrevor1", "threaten_ortega_endloop_ort", "Neko Repent", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair13"] = {"misstrevor3", "bike_chat_a_1", "Neko Sit Chair 13", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekocheck"] = {"misstvrram_5", "marines_idle_b", "Neko Check", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekowash"] = {"timetable@floyd@clean_kitchen@idle_a", "idle_a", "Neko Wash", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekowash2"] = {"timetable@floyd@clean_kitchen@base", "base", "Neko Wash 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositpost"] = {"switch@michael@smoking2", "loop", "Neko Sit Post", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost2"] = {"switch@trevor@pushes_bodybuilder", "001426_03_trvs_5_pushes_bodybuilder_idle_bb2", "Neko Sit Post 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost3"] = {"timetable@reunited@ig_10", "base_jimmy", "Neko Sit Post 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost4"] = {"anim@heists@fleeca_bank@hostages@intro", "intro_loop_ped_a", "Neko Sit Post 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost5"] = {"anim@amb@office@pa@male@", "greetng_b_intro", "Neko Sit Post 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositmafia3"] = {"anim@amb@office@boss@female@", "idle_d", "Neko Sit Mafia 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost6"] = {"timetable@ron@ig_3_p3", "ig_3_p3_base", "Neko Sit Post 6", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost7"] = {"timetable@trevor@smoking_meth@idle_a", "idle_a", "Neko Sit Post 7", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrunk2"] = {"timetable@tracy@ig_7@base", "base", "Neko Drunk 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoverydrunk"] = {"timetable@tracy@ig_7@idle_a", "idle_a", "Neko Very Drunk", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrunk3"] = {"timetable@tracy@ig_7@idle_a", "idle_b", "Neko Drunk 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoparody"] = {"anim@mp_player_intupperthumb_on_ears", "idle_a", "Neko Parody", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody2"] = {"anim@mp_player_intincarthumb_on_earsstd@ps@", "idle_a", "Neko Parody 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody3"] = {"anim@mp_player_intincarfreakoutstd@rps@", "idle_a", "Neko Parody 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody4"] = {"anim@mp_player_intcelebrationmale@thumb_on_ears", "thumb_on_ears", "Neko Parody 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody5"] = {"anim@mp_player_intcelebrationfemale@thumb_on_ears", "thumb_on_ears", "Neko Parody 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoshow"] = {"missfbi_s4mop", "lobby_security_fp_player", "Neko Show", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},
   ["Nekopicksnot"] = {"anim@mp_player_intincarnose_pickstd@ps@", "exit", "Neko Pick snot", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},
   ["Nekoparody6"] = {"anim@mp_player_intincardockbodhi@rds@", "idle_a_fp", "Neko Parody 6", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekofear2"] = {"anim@heists@prison_heistunfinished_biz@popov_react", "popov_flinch_a", "Neko Fear 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear3"] = {"anim@heists@prison_heistunfinished_biz@popov_react", "popov_flinch_b", "Neko Fear 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoheartbroken"] = {"anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle", "Neko Heart Broken", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear4"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_c", "Neko Fear 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear5"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_d", "Neko Fear 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoincite"] = {"fos_ep_1_p5-1", "csb_anita_dual-1", "Neko Incite", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
--    ["Nekomasturbate"] = {"switch@trevor@jerking_off", "trev_jerking_off_exit", "Neko Masturbate", AnimationOptions =
--    {   
--        EmoteLoop = false,
--        EmoteMoving = false,
    
--    }},
--    ["Nekomasturbate2"] = {"switch@trevor@jerking_off", "trev_jerking_off_loop", "Neko Masturbate 2", AnimationOptions =
--    {   
--        EmoteLoop = true,
--        EmoteMoving = false,
    
--    }},
   ["Nekotest87"] = {"switch@trevor@puking_into_fountain", "trev_fountain_puke_loop", "Neko test87", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
--    ["Nekotest88"] = {"timetable@trevor@skull_loving_bear", "skull_loving_bear", "Neko test88", AnimationOptions =
--    {   
--        EmoteLoop = true,
--        EmoteMoving = false,
    
--    }},
   ["Nekotest89"] = {"anim@move_hostages@male", "male_idle_to_cower", "Neko test89", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},
   ["Nekositmassage"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_floyd", "Neko Sit Massage", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_trevor", "Neko Massage", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage2"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_floyd", "Neko Massage 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage3"] = {"missheistdocks2bleadinoutlsdh_2b_int", "leg_massage_b_floyd", "Neko Massage 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage4"] = {"missheistdocks2bleadinoutlsdh_2b_int", "leg_massage_floyd", "Neko Massage 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   
   
   
   ["Nekofoldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Neko Fold Arms 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekocrossarms6"] = {"random@shop_gunstore", "_idle", "Neko Crossarms 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   -------------------
   ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Fold Arms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Crossarms Side", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["surrender"] = {"random@arrests@busted", "idle_a", "Surrender", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
   ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
   ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Finger", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Finger 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Wait 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hiking"] = {"move_m@hiking", "idle", "Hiking", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug"},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Knock", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Knock 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knuckle Crunch", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leanside", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leanside 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leanside 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Me", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mechanic"] = {"mini@repair", "fixing_a_ped", "Mechanic", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mechanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Medic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditiate", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditiate 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Meditiate 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Nose Pick", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "No Way", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Out of Breath", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Push", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Push 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Point", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Countdown", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Point Right", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salute", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salute 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salute 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Scared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "Screw You", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Shake Off", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Shot", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Sleep", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Shrug", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Shrug 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sit", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Sit 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sit 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sit 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sit 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sit 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sit 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sit 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sit 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sit Lean", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sit Sad", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sit Scared", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sit Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sit Scared 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Sit Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sit Chair 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Sit Chair 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Sit Chair 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sit Chair 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "Sit Chair 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sit Chair Side", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit Up", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Clap Angry", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Slow Clap 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Slow Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Slow Clap 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Smell", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "stumble", "Stumble", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Stunned", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Sunbathe", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Sunbathe 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Think", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think3"] = {"timetable@tracy@ig_8@base", "base", "Think 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Think 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Thumbs Up 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Thumbs Up 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Thumbs Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Type", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Type 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Type 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Type 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Wave 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Wave 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Wave 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Wave", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave5"] = {"friends@frj@ig_1", "wave_b", "Wave 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave6"] = {"friends@frj@ig_1", "wave_c", "Wave 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave7"] = {"friends@frj@ig_1", "wave_d", "Wave 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave8"] = {"friends@frj@ig_1", "wave_e", "Wave 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whistle"] = {"taxi_hail", "hail_taxi", "Whistle", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Whistle 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Lift", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["passout"] = {"missarmenian2", "drunk_loop", "Passout", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Passout 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Passout 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Passout 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Passout 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Crawl", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Flip 2"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Flip"},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flip Off", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flip Off 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Bow", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Bow 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Key Fob", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Reaching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait"] = {"random@shop_tattoo", "_idle_a", "Wait", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wait 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait12"] = {"rcmjosh1", "idle", "Wait 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait13"] = {"rcmnigel1a", "base", "Wait 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Fish Dance", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Air Plane", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Cough", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stretch"] = {"mini@triathlon", "idle_e", "Stretch", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "Stretch 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "Stretch 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Stretch 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Celebrate", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Punching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Superhero", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Superhero 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Mind Control", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Mind Control 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Try Clothes", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Try Clothes 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Try Clothes 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervous 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervous", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nervous 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uncuff"] = {"mp_arresting", "a_uncuff", "Uncuff", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Pull", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Bird"},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Chicken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Bark"},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Rabbit"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Adjust", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Hands Up", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Bum Bin"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
   ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Cheer"},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Chinup"},
   ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Clipboard 2"},
   ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Cop"},
   ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Cop Beacon"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Film Shocking"},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
   ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guard"},
   ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Hammer"},
   ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Hangout"},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Jog"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Kneel"},
   ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Leafblower"},
   ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Lean"},
   ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Lean Bar"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Lookout"},
   ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Maid"},
   ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medic"},
   ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musician"},
   ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notepad 2"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parking Meter"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
   ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Texting"},
   ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitue High"},
   ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitue Low"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Puddle"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Record"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sit Chair"},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Smoke Weed"},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statue"},
   ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
   --["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"},
   ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Weld"},
   ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Window Shop"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Cut Throat"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Cut Throat 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Think 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Adjust Tie", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},

   -- Penguin
   ["G7penguin_mppos_pose2_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose2_v5", "Penguin Chill Welcome", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["H5penguin_mppos_pose9_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose9_v5", "Penguin Ascending", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["H6penguin_mppos_pose10_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose10_v5", "Penguin Ghost On Shoulder", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["0000oudtoothless"] = {"oudoud@toothlessdance", "oudoud_sambadance", "OudOud Toothless Dance ~q~ Tiktok", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false
   }},

   -- Glap
   ["00Glap_The-ghost"] = {"glap@the-ghost", "the-ghost", "Glap The Ghost Tiktok", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["00Glap_Oho-ther-anim"] = {"glap@oho-ther-waan-jiab", "oho-ther-waan-jiab_anim", "Glap Oho ther waan jiab Animation", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},    
   ["00Glap_Oho-ther-pose"] = {"glap@oho-ther-waan-jiab", "oho-ther-waan-jiab_pose", "Glap Oho ther waan jiab Pose", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},    
   ["0Glap_Jimnaamjum"] = {"glap@jimnaamjum", "jimnaamjum_clip", "Glap JimNaamJum Animation", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["0Glap_Jimnaamjum_Walk"] = {"glap@jimnaamjum", "jimnaamjum_clip", "Glap JimNaamJum Walk", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["0Glap_Tono"] = {"glap@tono", "tono_clip", "Glap Tono Start Animation", AnimationOptions =
   {
       Prop = "prop_microphone_02",
       PropBone = 18905,
       PropPlacement = {0.10, -0.07, 0.01, -80.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["AGlap_Loum"] = {"glap@loumpadteung", "loum_clip", "Glap LoumPadTeung Tiktok", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["0A1Glap_Matsuri"] = {"glap@matsuri", "matsuri_clip", "Glap Matsuri Tiktok", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["0A1Glap_Collide"] = {"glap@collide", "collide_clip", "Glap Collide Tiktok", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},

}

DP.PropEmotes = {
   ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Umbrella", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notepad", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Box", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rose", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Book", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddy", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Backpack", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard"] = {"missfam4", "base", "Clipboard", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Map", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Beg", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   -- Penguin
   ["G6penguin_mppos_pose1_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose1_v5", "Penguin Neck Flower", AnimationOptions =
   {
       Prop = "flower_neck",  
       PropBone = 24818,
       PropPlacement = {-0.30, 0.04, 0.0, -3.0, 90.0, 180.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["G8penguin_mppos_pose3_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose3_v5", "Penguin Find", AnimationOptions =
   {
       Prop = "find",  
       PropBone = 60309,
       PropPlacement = {0.05, 0.11, -0.01, -4.0, 92.0, -19.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["G9penguin_mppos_pose4_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose4_v5", "Penguin Red Card", AnimationOptions =
   {
       Prop = "red_card",  
       PropBone = 28422,
       PropPlacement = {0.11, 0.07, -0.05, -23.0, -61.0, 131.0},
       SecondProp = 'whistle',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.09, 0.04, 0.04, -94.0, 186.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["H1penguin_mppos_pose5_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose5_v5", "Penguin Yellow Card", AnimationOptions =
   {
       Prop = "yellow_card",  
       PropBone = 28422,
       PropPlacement = {0.11, 0.07, -0.05, -23.0, -61.0, 131.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["H2penguin_mppos_pose6_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose6_v5", "Penguin Water Tank", AnimationOptions =
   {
       Prop = "watertank",  
       PropBone = 60309,
       PropPlacement = {0.12, 0.0, 0.09, 181.0, 23.0, -116.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["H3penguin_mppos_pose7_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose7_v5", "Penguin Flag", AnimationOptions =
   {
       Prop = "penguin_flag2",  
       PropBone = 28422,
       PropPlacement = {0.09, -0.4, -0.18, -85.0, 65.0, 20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["H4penguin_mppos_pose8_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose8_v5", "Penguin Logo", AnimationOptions =
   {
       Prop = "logo_label",  
       PropBone = 28422,
       PropPlacement = {0.2, 0.08, -0.03, -47.0, 128.0, 55.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   -- 789 store

--    ["780flower1"] = {"789@flower1", "flower1", "Give Duck 1", AnimationOptions =
--    {
--        Prop = 'duck1',
--        PropBone = 4153,
--        PropPlacement = {0.030054450467219, -0.11020383487048, -0.1527749708202, -14.326021970728, -3.5511486207354, -112.65035719291},
--        EmoteLoop = true,
--        EmoteMoving = true,
--    }},

--    ["780flower2"] = {"789@flower2", "flower2", "Give Duck 2", AnimationOptions =
--    {
--        Prop = 'duck1',
--        PropBone = 58866,
--        PropPlacement = {0.11233744067965, -0.12042338531797, -0.023271139717634, -126.71935681192, -6.9852780117021, -3.6743306093318},
--        EmoteLoop = true,
--        EmoteMoving = true,
--    }},

--    ["780flower3"] = {"789@flower3", "flower3", "Give Duck 3", AnimationOptions =
--    {
--        Prop = 'duck1',
--        PropBone = 58866,
--        PropPlacement = {0.034454983948422, -0.2063411428861, 0.012195577712406, -117.63964451406, -2.2193456397715, -5.2175128426961},
--        EmoteLoop = true,
--        EmoteMoving = true,
--    }},

--    ["780flower4"] = {"789@flower4", "flower4", "Give Duck 4", AnimationOptions =
--    {
--        Prop = 'duck1',
--        PropBone = 4153,
--        PropPlacement = {0.067422151530991, -0.038705786881022, -0.001461691701005, -0.50424862754229, 18.764436709017, -23.953912297513},
--        EmoteLoop = true,
--        EmoteMoving = true,
--    }},
   ["789sea1"] = {"789@sea1", "sea1", "789Store Flowers Bukey 1", AnimationOptions =
   {
       Prop = 'bukey',
       PropBone = 4153,
       PropPlacement = {0.01996636249396, 0.015667062070794, 0.065533160790099, 27.861832698521, 29.804747884453, -3.6105317556801},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789sea2"] = {"789@sea2", "sea2", "789Store Flowers Bukey 2", AnimationOptions =
   {
       Prop = 'bukey',
       PropBone = 4153,
       PropPlacement = {-0.0028344879153792, -0.023864866746661, 0.10240004765607, 54.094935393447, 31.135150255574, 51.010552666091},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789sea3"] = {"789@sea3", "sea3", "789Store Flowers Bukey 3", AnimationOptions =
   {
       Prop = 'bukey',
       PropBone = 58866,
       PropPlacement = {0.029755325064002, -0.091440710603513, -0.0762859993991, -60.376256802098, 15.623603976639, -59.87815558495},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789luxury1"] = {"789@luxury1", "luxury1", "789Store Luxury Girl 1", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.66354045852722, -0.5019733761766, -0.19232868340326, -0.97021658161214, -86.124953970833, 167.2421783327},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury2"] = {"789@luxury2", "luxury2", "789Store Luxury Girl 2", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.44392650581324, -0.51794206870056, -0.36028465789252, 7.9261809537865, -69.079176532156, 164.94948789817},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury3"] = {"789@luxury3", "luxury3", "789Store Luxury Girl 3", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.77751962637285, -0.54804875901014, -0.10974081001545, -169.77164674442, 76.180289814468, 28.362434773655},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury4"] = {"789@luxury4", "luxury4", "789Store Luxury Girl 4", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = { 0.70632487684418, -0.38220034138812, 0.19451336387125, 165.02843049787, 59.367925076423, 12.859638809162},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury5"] = {"789@luxury5", "luxury5", "789Store Luxury Girl 5", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.6139483781584, -0.71593610945974, -0.001695678375509, -157.18769107177, 79.199727527202, 10.711487923791},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury6"] = {"789@luxury6", "luxury6", "789Store Luxury Girl 6", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.58880814107295, -0.68826006206108, -0.0034661827322862, -160.25176148426, 79.307480699745, 4.1947263775771},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury7"] = {"789@luxury7", "luxury7", "789Store Luxury Girl 7", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.65921292009216, -0.61139201708481, -0.015726756786829, -160.16327638707, 78.137524028462, 10.351426329369},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury8"] = {"789@luxury8", "luxury8", "789Store Luxury Girl 8", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.59779302380718, -0.62774609708753, -0.047398944164342, -159.46498327074, 74.528058187706, 19.386462568878},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury9"] = {"789@luxury9", "luxury9", "789Store Luxury Girl 9", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.37309834312998, -0.58590625278823, -0.32464572514048, 17.315896652337, -71.639860996395, 160.53072709295},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury10"] = {"789@luxury10", "luxury10", "789Store Luxury Girl 10", AnimationOptions =
   {
       Prop = 'lx6',
       PropBone = 36864,
       PropPlacement = {0.33099019233725, -0.56388667328821, -0.36800920129844, 16.430528492448, -71.890756552141, 162.59341902244},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury11"] = {"789@luxury11", "luxury11", "789Store Luxury Boy 1", AnimationOptions =
   {
       Prop = 'lx4',
       PropBone = 36864,
       PropPlacement = {0.71779084766638, -0.68733802506309, 0.29498402561355, -156.40513351956, 43.130719291727, -5.1825452033723},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury12"] = {"789@luxury12", "luxury12", "789Store Luxury Boy 2", AnimationOptions =
   {
       Prop = 'lx4',
       PropBone = 36864,
       PropPlacement = {0.42457310524605, -0.70877173152598, 0.4382776204, -167.79390251827, 32.692391658467, 5.5520685725628},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury13"] = {"789@luxury13", "luxury13", "789Store Luxury Boy 3", AnimationOptions =
   {
       Prop = 'lx5',
       PropBone = 36864,
       PropPlacement = {0.22889564586796, -0.85391472060844, 0.63567708024575, -175.12182608992, 2.7221580995483, 4.6716348505274},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury14"] = {"789@luxury14", "luxury14", "789Store Luxury Boy 4", AnimationOptions =
   {
       Prop = 'lx5',
       PropBone = 63931,
       PropPlacement = {0.25726890071837, -1.0536741790505, -0.21142060823107, 14.078581657024, -64.156942950753, 163.74225869794},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury15"] = {"789@luxury15", "luxury15", "789Store Luxury Boy 5", AnimationOptions =
   {
       Prop = 'lx4',
       PropBone = 63931,
       PropPlacement = {0.43241637751305, -0.62029757759846, -0.18300073059316, 12.831982619164, -73.819264575416, 156.71144113544},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789luxury16"] = {"789@luxury16", "luxury16", "789Store Luxury Boy 6", AnimationOptions =
   {
       Prop = 'lx5',
       PropBone = 36864,
       PropPlacement = {0.53174227296483, -0.83440935434074, 0.41043032824195, -157.25742245593, 49.005660864528, -10.933468157508},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
--    ["789carebears1"] = {"789@carebears1", "carebears1", "789Store carebears1", AnimationOptions =
--    {
--        Prop = 'carebear1',
--        PropBone = 64017,
--        PropPlacement = {-0.070952082224835, -0.1470324266546, -0.092189326355779, -86.135998612584, -7.5690877994799, -59.149806613129},
--        EmoteLoop = true,
--        EmoteMoving = false,
--    }},
--    ["789carebears2"] = {"789@carebears2", "carebears2", "789Store carebears2", AnimationOptions =
--    {
--        Prop = 'carebear2',
--        PropBone = 26611,
--        PropPlacement = {-0.15985349324478, -0.16139110828798, -0.20680997297944, -40.248930888248, 73.255189033736, 54.460952003487},
--        EmoteLoop = true,
--        EmoteMoving = false,
--    }},
--    ["789carebears3"] = {"789@carebears3", "carebears3", "789Store carebears3", AnimationOptions =
--    {
--        Prop = 'carebear3',
--        PropBone = 64017,
--        PropPlacement = {-0.016594074627619, -0.17477312688556, -0.10721648452881, -82.371561446166, -10.417052152636, -11.043856415132},
--        EmoteLoop = true,
--        EmoteMoving = false,
--    }},
   ["789carebears4"] = {"789@carebears4", "carebears4", "789Store Give Duck 1", AnimationOptions =
   {
       Prop = 'duck1', -- ของเปลี่ยนเป็นน้องเป็ดเพราะขนาดของน้องเข้ากับตัว emote มากกว่าครับ
       PropBone = 64017,
       PropPlacement = {-0.013095511226766, -0.065935284089864, -0.18937963955647, -41.950929381958, 1.4117624876885, 13.741119384956},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
--    ["789carebears5"] = {"789@carebears5", "carebears5", "789Store carebears5", AnimationOptions =
--    {
--        Prop = 'carebear5',
--        PropBone = 64017,
--        PropPlacement = {-0.040617140396193, -0.14916955467085, -0.10238659021836, -88.02407033022, 6.5542703637805, -22.439342571953},
--        EmoteLoop = true,
--        EmoteMoving = false,
--    }},
--    ["789carebears6"] = {"789@carebears6", "carebears6", "789Store carebears6", AnimationOptions =
--    {
--        Prop = 'carebear6',
--        PropBone = 64017,
--        PropPlacement = {-0.0083364042950507, -0.17397458781323, -0.11536309265092, -87.20479211465, -1.3478934913179, -22.107674268204},
--        EmoteLoop = true,
--        EmoteMoving = false,
--    }},
   ["789carebears7"] = {"789@carebears7", "carebears7", "789Store Give Duck 2", AnimationOptions =
   {
       Prop = 'duck1', -- ของเปลี่ยนเป็นน้องเป็ดเพราะขนาดของน้องเข้ากับตัว emote มากกว่าครับ
       PropBone = 64017,
       PropPlacement = {0.070497174269576, -0.048199167451237, -0.15118499757418, -41.99358105582, 24.081643529699, -22.209997751416},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789catpose1"] = {"789@catpose1", "catpose1", "789Store Cat 1", AnimationOptions =
   {
       Prop = 'cat1', 
       PropBone = 64017,
       PropPlacement = {-0.16500644391601, -0.12239827852856, -0.068885030957353, -76.695268130933, 16.306854162298, -57.855941093617},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789catpose2"] = {"789@catpose2", "catpose2", "789Store Cat 2", AnimationOptions =
   {
       Prop = 'cat3',
       PropBone = 64017,
       PropPlacement = {-0.041772808178848, -0.12877652561382, -0.070249676224602, -66.873845751189, -42.050790117573, -41.920469547407},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789catpose3"] = {"789@catpose3", "catpose3", "789Store Cat 3", AnimationOptions =
   {
       Prop = 'cat4', 
       PropBone = 64017,
       PropPlacement = {-0.12542831913765, -0.035290706075962, -0.17297521388854, -19.121391855582, 41.498727357637, -9.7172195160361},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789catpose4"] = {"789@catpose4", "catpose4", "789Store Cat 4", AnimationOptions =
   {
       Prop = 'cat3', 
       PropBone = 64017,
       PropPlacement = {-0.04627011748903, -0.13810677045652, -0.15581111319616, -28.460862620006, 32.230756289628, 2.2894432210143},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789catpose5"] = {"789@catpose5", "catpose5", "789Store Cat 5", AnimationOptions =
   {
       Prop = 'cat2', 
       PropBone = 18905,
       PropPlacement = {0.23617751891084, -0.031642700321252, 0.097726345663256, 80.244012335238, 2.4119593142801, -117.7375588582},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme1"] = {"book@kissme1", "kissme", "789Store Book 1", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 64017,
       PropPlacement = {0.074763909469198, 0.055857405380538, -0.078841256207274, 39.900889495777, 61.795552591749, 27.572185376737},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme2"] = {"book@kissme2", "kissme", "789Store Book 2", AnimationOptions =
   {
       Prop = 'book1', 
       PropBone = 64017,
       PropPlacement = {0.017445483194024, -0.077828247644145, -0.048447634169874, 23.212048382762, 57.551959751612, 138.43157978231},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme3"] = {"book@kissme3", "kissme", "789Store Book 3", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 64017,
       PropPlacement = {0.091020447434403, -0.077359919658063, -0.031467152774279, 17.732649783341, 36.329122166944, -55.375363937193},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme4"] = {"book@kissme4", "kissme", "789Store Book 4", AnimationOptions =
   {
       Prop = 'book1', 
       PropBone = 4089,
       PropPlacement = {0.0, -0.040876795810657, 0.0038341380333003, -4.2404264319624, 81.487870068311, -116.61914173682},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme5"] = {"book@kissme5", "kissme", "789Store Book 5", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 64017,
       PropPlacement = {0.025191433142822, 0.085374457065531, -0.005462968113281, 49.418712615007, 53.333906047624, -14.277209490282},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789bookkissme6"] = {"book@kissme6", "kissme", "789Store Book 6", AnimationOptions =
   {
       Prop = 'book1', 
       PropBone = 64017,
       PropPlacement = {0.11050488970443, -0.16352433529012, -0.071921398179966, 74.84962588877, 16.64943809959, 177.71369247973},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789kissme_f1_1"] = {"book@kissme_f1_1", "kissme", "789Store Book 7", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 64017,
       PropPlacement = {0.057665352561571, -0.07160904664613, -0.082531402920935, 16.320908919061, 37.224103475745, 10.986072738524},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789kissme_f1_2"] = {"book@kissme_f1_2", "kissme", "789Store Book 8", AnimationOptions =
   {
       Prop = 'book1', 
       PropBone = 58868,
       PropPlacement = {0.029477107035973, 0.063295607938359, 0.0038231619858153, -12.439657076681, 73.642735584717, -146.53112870037},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789kissme_f2_1"] = {"book@kissme_f2_1", "kissme", "789Store Book 9", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 58868,
       PropPlacement = {0.071803361519983, 0.082572661807282, 0.096136327836873, 103.55362869217, 39.752019610506, 30.275077138694},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789kissme_f2_2"] = {"book@kissme_f2_2", "kissme", "789Store Book 10", AnimationOptions =
   {
       Prop = 'book2', 
       PropBone = 58868,
       PropPlacement = {0.066996271358789, 0.12128159060213, 0.0011805849441909, 119.59254691869, 4.3553049500245, 39.385337551105},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789cityyou1"] = {"789@cityyou1", "cityyou1", "789Store Polaroid 1", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.065992884192156, 0.085808183190808, 0.0076100985594573, -0.83726763267037, 0.51286126846156, 57.469894830072},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789cityyou2"] = {"789@cityyou2", "cityyou2", "789Store Polaroid 2", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.053132680940053, 0.019254468366203, -0.0064997662187269, -81.430921791973, 1.7732842191552, 8.9396296369409},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789cityyou3"] = {"789@cityyou3", "cityyou3", "789Store Polaroid 3", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.030625249485638, 0.12022708334484, -0.022334375979532, 124.45588882208, -14.375178246308, 12.784782025627},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789cityyou4"] = {"789@cityyou4", "cityyou4", "789Store Polaroid 4", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.03121625414758, 0.028925059968845, -0.035105678841845, 68.409135493008, 13.647398372173, -168.02379450638},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789cityyou5"] = {"789@cityyou5", "cityyou5", "789Store Polaroid 5", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.067869033336819, 0.10316069264185, 0.019381637064164, 63.457865067226, 1.5665547493694, 69.97329346778},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789cityyou6"] = {"789@cityyou6", "cityyou6", "789Store Polaroid 6", AnimationOptions =
   {
       Prop = 'polaroid', 
       PropBone = 58868,
       PropPlacement = {0.0, 0.12003532631099, -0.0074752867686812, 74.915279241217, -1.890689718118, 60.572114568287},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot1"] = {"789@forgetmenot1", "forgetmenot1", "789Store Foget Me Not 1", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58866,
       PropPlacement = {-0.035447006119625, -0.046304481040381, 0.0057618380420146, 32.663446890048, 43.106998443695, 112.45541676698},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot2"] = {"789@forgetmenot2", "forgetmenot2", "789Store Foget Me Not 2", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {0.026074108418356, 0.085810336751167, -0.10846414619004, 19.726982372972, 13.492914242826, -6.5654398193424},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot3"] = {"789@forgetmenot3", "forgetmenot3", "789Store Foget Me Not 3", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {0.04595092182899, 0.072509422267336, -0.10802988034584, 16.598668621535, 0, 0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot4"] = {"789@forgetmenot4", "forgetmenot4", "789Store Foget Me Not 4", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {-0.028692746829961, 0.11497577765453, -0.098061782174048, 30.68710693479, 20.622842428462, 15.338530095887},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot5"] = {"789@forgetmenot5", "forgetmenot5", "789Store Foget Me Not 5", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {0.0043635442406185, 0.069295336418563, -0.085678762756473, 18.683048957468, 13.458914694195, 19.75016366118},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot6"] = {"789@forgetmenot6", "forgetmenot6", "789Store Foget Me Not 6", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {-0.015238392306969, 0.12228460386931, -0.10117548688393, 28.965247572321, 32.688504270377, -21.209580530546},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789forgetmenot7"] = {"789@forgetmenot7", "forgetmenot7", "789Store Foget Me Not 7", AnimationOptions =
   {
       Prop = 'flower1', 
       PropBone = 58868,
       PropPlacement = {0.012971005936834, 0.13001612887078, -0.075375430546369, 45.14018537645, 10.27069725222, 17.805606832192},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789hamster1"] = {"789@hamster1", "hamster1", "789Store Hamster 1", AnimationOptions =
   {
       Prop = 'hamster1', 
       PropBone = 58868,
       PropPlacement = {0.0025907002988106, 0.067905889416534, 0.0087005353152802, -35.893402804218, 65.213244858814, 26.162130635037},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789hamster2"] = {"789@hamster2", "hamster2", "789Store Hamster 2", AnimationOptions =
   {
       Prop = 'hamster2', 
       PropBone = 26611,
       PropPlacement = {-0.00760961625042, -0.059178845423942, -0.003683150720893, 109.71066249592, -29.24881309859, 104.12023566785},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789hamster3"] = {"789@hamster3", "hamster3", "789Store Hamster 3", AnimationOptions =
   {
       Prop = 'hamster3', 
       PropBone = 26611,
       PropPlacement = {0.00084021780935473, -0.055595057082323, -0.016706731802984, 106.43021482701, -77.38284565005, 26.054019092448},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789hamster4"] = {"789@hamster4", "hamster4", "789Store Hamster 4", AnimationOptions =
   {
       Prop = 'hamster4', 
       PropBone = 26611,
       PropPlacement = {-0.02997712847241, -0.023344564103077, -0.035737560761748, -91.646783585052, 65.072370979399, 166.04011419605},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789krathong1"] = {"789@krathong1", "krathong1", "789Store Krathong 1", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.09152619910742, -0.10668883017948, 0.0081118476848927, -1.7627966460619, -39.310525490217, 18.736863941836},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789krathong2"] = {"789@krathong2", "krathong2", "789Store Krathong 2", AnimationOptions =
   {
       Prop = 'krathong2', 
       PropBone = 58866,
       PropPlacement = {0.060358538244827, -0.099910200476987, -0.030079733443068, -159.47534646749, -14.696461634593, 4.1101638477876e-16},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789krathong3"] = {"789@krathong3", "krathong3", "789Store Krathong 3", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.062976027411992, -0.075081874122416, -0.047654481672903, 30.006507657992, -4.5291972877324, -10.941900268995},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789krathong4"] = {"789@krathong4", "krathong4", "789Store Krathong 4", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.11515855124685, -0.058970373429194, 0.065446261844782, 4.5923183159819, -75.499461524767, 92.706603834246},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789krathong5"] = {"789@krathong5", "krathong5", "789Store Krathong 5", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.11705776285362, -0.073689444816816, 0.049344415160288, -10.186259574411, -50.281934400445, 41.108589449263},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["babyqueenkrathong1"] = {"babyqueen@krathong1", "krathong1", "789Store Krathong 6", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.086747830188642, -0.054252081115161, -0.078021615475719, 104.02568656009, 61.740018863974, -20.73636601012},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["babyqueenkrathong2"] = {"babyqueen@krathong2", "krathong2", "789Store Krathong 7", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 58866,
       PropPlacement = {0.11316475687875, -0.14970588212856, 0.015807212681922, -166.17821330156, -18.480555236207, 22.664535895176},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["babyqueenkrathong3"] = {"babyqueen@krathong3", "krathong3", "789Store Krathong 8", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 58866,
       PropPlacement = {0.062714086373148, -0.074621335162243, 0, 174.67776952256, -15.424309456771, -164.39190754963},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["babyqueenkrathong4"] = {"babyqueen@krathong4", "krathong4", "789Store Krathong 9", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 58866,
       PropPlacement = {0.077725150668584, -0.10950399475565, 0.0034223362721601, -176.61691078287, -17.833351090626, 25.657498349321},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["babyqueenkrathong5"] = {"babyqueen@krathong5", "krathong5", "789Store Krathong 10", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 58866,
       PropPlacement = {0.078598230340958, -0.096508546662196, 0.015461907418332, 87.153416160203, 78.373119416487, 87.093884104134},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["babyqueenkrathong6"] = {"babyqueen@krathong6", "krathong6", "789Store Krathong 11", AnimationOptions =
   {
       Prop = 'krathong1', 
       PropBone = 26611,
       PropPlacement = {0.050656082843602, -0.054791720478979, -0.039578074697438, 62.490338634722, 0, 0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gracecustomthail1"] = {"grace@customthail1", "customthail1", "789Store Flow Lantern 1", AnimationOptions =
   {
       Prop = 'flowlantern1', 
       PropBone = 26611,
       PropPlacement = {0.021995875036623, -0.23000425390662, -0.014501644661247, 2.0856402614557, 7.6323779369221, 16.114255893766},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gracecustomthail2"] = {"grace@customthail2", "customthail2", "789Store Flow Lantern 2", AnimationOptions =
   {
       Prop = 'flowlantern2', 
       PropBone = 26611,
       PropPlacement = {0.015839208677789, -0.23120322649716, -0.0034709024196524, 4.2259176528167, 6.4786697587639, 0.47767975738853},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gracecustomthail3"] = {"grace@customthail3", "customthail3", "789Store Flow Lantern 3", AnimationOptions =
   {
       Prop = 'flowlantern3', 
       PropBone = 26611,
       PropPlacement = {0.016333801752012, -0.23152712573487, 0.00054371427988309, 3.7673093940719, 8.1389514804313, 0.20604624433675},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["gracecustomthail4"] = {"grace@customthail4", "customthail4", "789Store Flow Lantern 4", AnimationOptions =
   {
       Prop = 'flowlantern4', 
       PropBone = 26611,
       PropPlacement = {0.15694120307762, -0.22050249566103, -0.01193637968464, -1.6572757668626, 6.828675006033, 0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789duckkrathong1"] = {"789@duckkrathong1", "duckkrathong1", "789Store Duck Krathong 1", AnimationOptions =
   {
       Prop = 'duck_kt1', 
       PropBone = 26611,
       PropPlacement = {-0.019862859904379, -0.05819284353689, -0.0068328630638944, -72.001145926181, 73.292256385906, 171.01889041421},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkrathong2"] = {"789@duckkrathong2", "duckkrathong2", "789Store Duck Krathong 2", AnimationOptions =
   {
       Prop = 'duck_kt2', 
       PropBone = 26611,
       PropPlacement = {0.012091991692046, -0.048009525219351, -0.0092551096367821, -81.122108457279, 74.446157178989, 162.8234977662},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkrathong3"] = {"789@duckkrathong3", "duckkrathong3", "789Store Duck Krathong 3", AnimationOptions =
   {
       Prop = 'duck_kt3', 
       PropBone = 26611,
       PropPlacement = {-0.019574001356432, -0.0381747688676, -0.059374940493554, -68.762966882907, 12.340681808727, 177.66128399582},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkrathong4"] = {"789@duckkrathong4", "duckkrathong4", "789Store Duck Krathong 4", AnimationOptions =
   {
       Prop = 'duck_kt4', 
       PropBone = 26611,
       PropPlacement = {0.018615448190758, -0.032872955030793, -0.060658778802559, -70.840441666659, 29.238941961201, 172.35186292801},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkrathong5"] = {"789@duckkrathong5", "duckkrathong5", "789Store Duck Krathong 5", AnimationOptions =
   {
       Prop = 'duck_kt5', 
       PropBone = 26611,
       PropPlacement = {0.0, -0.042314979924493, -0.070529365513105, -74.145418329475, 17.870607952373, 164.99338161771},
       SecondProp = 'cat2',
       SecondPropBone = 58866,
       SecondPropPlacement = { 0.24369215587603, -0.24092455827619, -0.089949571168201, -94.709374414782, 80.065690943519, 14.710131692958},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong1"] = {"789@duckkmini_rathong1", "duckkmini_rathong1", "789Store Duck Mini Krathong 1", AnimationOptions =
   {
       Prop = 'mini1', 
       PropBone = 26611,
       PropPlacement = {0.0038407790841575, -0.029807998186261, -0.0042082457882001, 60.911978021641, -29.130810171376, 34.160215615046},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong2"] = {"789@duckkmini_rathong2", "duckkmini_rathong2", "789Store Duck Mini Krathong 2", AnimationOptions =
   {
       Prop = 'mini2', 
       PropBone = 26611,
       PropPlacement = {0.018232895051597, -0.0065063741855786, -0.0070951766786296, 53.015215286204, 0.14328474560338, 30.107214553798},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong3"] = {"789@duckkmini_rathong3", "duckkmini_rathong3", "789Store Duck Mini Krathong 3", AnimationOptions =
   {
       Prop = 'mini3', 
       PropBone = 26611,
       PropPlacement = {0.01865258438238, -0.031922087826047, -0.012509753078631, -47.978620996138, 33.583898055907, -178.74041774392},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong4"] = {"789@duckkmini_rathong4", "duckkmini_rathong4", "789Store Duck Mini Krathong 4", AnimationOptions =
   {
       Prop = 'mini4', 
       PropBone = 26611,
       PropPlacement = {0.0, -0.039849660378712, -0.027171032201126, -52.20836098446, 47.480340042351, 156.928002061},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong5"] = {"789@duckkmini_rathong5", "duckkmini_rathong5", "789Store Duck Mini Krathong 5", AnimationOptions =
   {
       Prop = 'mini5', 
       PropBone = 26611,
       PropPlacement = {0.0, -0.039498321288193, -0.024552147081167, -51.100229351293, 48.140899541393, 166.05752533658},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["789duckkmini_rathong6"] = {"789@duckkmini_rathong5", "duckkmini_rathong5", "789Store Duck Mini Krathong 6", AnimationOptions =
   {
       Prop = 'mini6', 
       PropBone = 26611,
       PropPlacement = {0.0, -0.039498321288193, -0.024552147081167, -51.100229351293, 48.140899541393, 166.05752533658},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["789duckkmini_rathong7"] = {"789@duckkmini_rathong1", "duckkmini_rathong1", "789Store Duck Mini Krathong 7", AnimationOptions =
   {
       Prop = 'mini7', 
       PropBone = 26611,
       PropPlacement = {0.0038407790841575, -0.029807998186261, -0.0042082457882001, 60.911978021641, -29.130810171376, 34.160215615046},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["789duckkmini_rathong8"] = {"789@duckkmini_rathong2", "duckkmini_rathong2", "789Store Duck Mini Krathong 8", AnimationOptions =
    {
        Prop = 'mini8', 
        PropBone = 26611,
        PropPlacement = {0.018232895051597, -0.0065063741855786, -0.0070951766786296, 53.015215286204, 0.14328474560338, 30.107214553798},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip1"] = {"789@tulip1", "tulip1", "789Store Give Tulip 1", AnimationOptions =
    {
        Prop = 'tulipbukey1', 
        PropBone = 58866,
        PropPlacement = {0.11687391664964, -0.10141378259527, 0.034968048474344, -66.726998111164, 69.41736305754, 10.83257618203},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip2"] = {"789@tulip2", "tulip2", "789Store Give Tulip 2", AnimationOptions =
    {
        Prop = 'tulip1', 
        PropBone = 58866,
        PropPlacement = {0.052687545630988, -0.10231442089936, 0.03866994572606, -92.082190950042, -4.7990141355672, -18.342028628093},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip3"] = {"789@tulip3", "tulip3", "789Store Give Tulip 3", AnimationOptions =
    {
        Prop = 'tulip2', 
        PropBone = 58866,
        PropPlacement = {0.029416151731766, -0.10762503789757, 0.0012416413437073, -70.875573836612, 18.793593777958, -30.816628592269},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip4"] = {"789@tulip4", "tulip4", "789Store Give Tulip 4", AnimationOptions =
    {
        Prop = 'tulip3', 
        PropBone = 58866,
        PropPlacement = {0.029312879926238, -0.10176910464768, 0.024148850797279, -80.511154216256, 17.564355949004, -32.856114304491},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip5"] = {"789@tulip5", "tulip5", "789Store Give Tulip 5", AnimationOptions =
    {
        Prop = 'tulip4', 
        PropBone = 58866,
        PropPlacement = {0.058949772908022, -0.099974546411377, 0.030606340840053, -81.368845150139, 19.225920126976, -12.565587919651},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip6"] = {"789@tulip6", "tulip6", "789Store Give Tulip 6", AnimationOptions =
    {
        Prop = 'tulip5', 
        PropBone = 58866,
        PropPlacement = {0.040688822081052, -0.088608057841107, 0.019066016631685, -104.84668842578, -51.393584999172, -20.932657160269},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip7"] = {"789@tulip7", "tulip7", "789Store Give Tulip 7", AnimationOptions =
    {
        Prop = 'tulipbukey2', 
        PropBone = 58866,
        PropPlacement = {0.022823490980613, -0.14751756009634, 0.0041439698491999, -55.3536712236, 84.73309373323, 5.9096064593561},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip8"] = {"789@tulip8", "tulip8", "789Store Give Tulip 8", AnimationOptions =
    {
        Prop = 'tulipbukey3', 
        PropBone = 58866,
        PropPlacement = {0.017904727915152, -0.14048455916417, -0.030778573188713, -49.253052714468, 55.558935988775, -3.4487907373118},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip9"] = {"789@tulip9", "tulip9", "789Store Give Tulip 9", AnimationOptions =
    {
        Prop = 'tulipbukey4', 
        PropBone = 58866,
        PropPlacement = {0.027085707009974, -0.11131036464532, -0.0092560774836156, -68.171405448014, 9.3626653774126, -24.253916538953},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["789tulip10"] = {"789@tulip10", "tulip10", "789Store Give Tulip 10", AnimationOptions =
    {
        Prop = 'tulipbukey5', 
        PropBone = 58866,
        PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    -- ["rainykissme1"] = {"rainy@kissme1", "kissme", "789Store Kiss Me 1", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme2"] = {"rainy@kissme2", "kissme", "789Store Kiss Me 2", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme3"] = {"rainy@kissme3", "kissme", "789Store Kiss Me 3", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme4"] = {"rainy@kissme4", "kissme", "789Store Kiss Me 4", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme5"] = {"rainy@kissme5", "kissme", "789Store Kiss Me 5", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme6"] = {"rainy@kissme6", "kissme", "789Store Kiss Me 6", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme_m1"] = {"rainy@kissme_m1", "kissme", "789Store Kiss Me Boy 1", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme_m2"] = {"rainy@kissme_m2", "kissme", "789Store Kiss Me Boy 2", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme_f1"] = {"rainy@kissme_f1", "kissme", "789Store Kiss Me Girl 1", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    -- ["rainykissme_f2"] = {"rainy@kissme_f2", "kissme", "789Store Kiss Me Girl 2", AnimationOptions =
    -- {
    --     Prop = 'blackumbrella', 
    --     PropBone = 58866,
    --     PropPlacement = {0.016485856481381, -0.15054840960309, -0.025890393578501, -71.052331460714, -1.9069127244297, -24.484120572086},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    -- }},
    ["789babycm_anim1"] = {"789@babycm_anim1", "babycm_anim1", "789 Babyxmas 1 ", AnimationOptions =
    {
        Prop = 'babycm_prop3', 
        PropBone = 0,
        PropPlacement = {0.000, 0.000, 0.045, 201.400, 177.200, 0.000,},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["789babycm_anim2"] = {"789@babycm_anim2", "babycm_anim2", "789 Babyxmas 2 ", AnimationOptions =
    {
        Prop = 'babycm_prop4', 
        PropBone = 0,
        PropPlacement = {0.000, 0.000, 0.000, 177.100, 181.100,0.000,},
        EmoteLoop = true,
        EmoteMoving = false,
    }},   
    ["789babycm_anim3"] = {"789@babycm_anim3", "babycm_anim3", "789 Babyxmas 3 ", AnimationOptions =
    {
        Prop = 'babycm_prop4', 
        PropBone = 0,
        PropPlacement = {-0.220, -0.185, 0.955, -157.400, 173.500, 0.000,},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["789babycm_anim4"] = {"789@babycm_anim4", "babycm_anim4", "789 Babyxmas 4 ", AnimationOptions =
    {
        Prop = 'babycm_prop2', 
        PropBone = 0,
        PropPlacement = {0.000,0.068,0.295,-167.300,-179.800,0.000,},
        EmoteLoop = true,
        EmoteMoving = false,
    }},  
    ["789babycm_anim5"] = {"789@babycm_anim5", "babycm_anim5", "789 Babyxmas 5 ", AnimationOptions =
    {
        Prop = 'babycm_prop1', 
        PropBone = 0,
        PropPlacement = {0.000, 0.195, 0.790, -171.200, -180.000, 0.000,},
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 




   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champagne Spray", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "Brief 3", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Phone Call", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phone"] = {"cellphone@", "cellphone_text_read_base", "Phone", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Clean", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Clean 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}