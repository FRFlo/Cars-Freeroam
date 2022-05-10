Locales['sv'] = {
  -- Inventory
  ['inventory'] = 'mitt förråd %s / %s',
  ['use'] = 'använd',
  ['give'] = 'ge',
  ['remove'] = 'kasta',
  ['return'] = 'gå tillbaka',
  ['give_to'] = 'ge till',
  ['amount'] = 'antal',
  ['giveammo'] = 'ge ammunition',
  ['amountammo'] = 'mängd ammunition',
  ['noammo'] = 'du har inte tillräckligt med ammunition!',
  ['gave_item'] = 'du gav ~y~%sx~s~ ~b~%s~s~ till ~y~%s~s~',
  ['received_item'] = 'du tog emot ~y~%sx~s~ ~b~%s~s~ från ~b~%s~s~',
  ['gave_weapon'] = 'du gav ~b~%s~s~ till ~y~%s~s~',
  ['gave_weapon_ammo'] = 'du gav ~o~%sx %s~s~ för ~b~%s~s~ till ~y~%s~s~',
  ['gave_weapon_withammo'] = 'du gav ~b~%s~s~ med ~o~%sx %s~s~ till ~y~%s~s~',
  ['gave_weapon_hasalready'] = '~y~%s~s~ har redan en ~y~%s~s~',
  ['gave_weapon_noweapon'] = '~y~%s~s~ har inte det vapnet',
  ['received_weapon'] = 'du tog emot ~b~%s~s~ från ~b~%s~s~',
  ['received_weapon_ammo'] = 'du tog emot ~o~%sx %s~s~ för ~b~%s~s~ från ~b~%s~s~',
  ['received_weapon_withammo'] = 'du tog emot ~b~%s~s~ med ~o~%sx %s~s~ från ~b~%s~s~',
  ['received_weapon_hasalready'] = '~b~%s~s~ försökte ge dig en ~y~%s~s~, men det vapnet har du redan',
  ['received_weapon_noweapon'] = '~b~%s~s~ försökte ge dig ammunition för ett ~y~%s~s~, men du har inget sådant vapen',
  ['gave_account_money'] = 'du gav ~g~%s SEK~s~ (%s) till ~y~%s~s~',
  ['received_account_money'] = 'du tog emot ~g~%s SEK~s~ (%s) från ~b~%s~s~',
  ['amount_invalid'] = 'ogiltig mängd',
  ['players_nearby'] = 'det finns inga spelare nära',
  ['ex_inv_lim'] = 'åtgärd inte möjligt, översteg förråd gräns för ~y~%s~s~',
  ['imp_invalid_quantity'] = 'åtgärd omöjlig, ogiltig mängd',
  ['imp_invalid_amount'] = 'åtgärd omöjlig, ogiltig belopp',
  ['threw_standard'] = 'du kastade ~y~%sx~s~ ~b~%s~s~',
  ['threw_account'] = 'du kastade ~g~%s SEK~s~ ~b~%s~s~',
  ['threw_weapon'] = 'du kastade ~b~%s~s~',
  ['threw_weapon_ammo'] = 'du kastade ~b~%s~s~ med ~o~%sx %s~s~',
  ['threw_weapon_already'] = 'du har redan ett sådant vapen på dig',
  ['threw_cannot_pickup'] = 'du kan inte plocka upp det på grund av att det kommer ej få plats i ditt förråd!',
  ['threw_pickup_prompt'] = 'tryck ~y~E~s~ för att plocka upp',

  -- Key mapping
  ['keymap_showinventory'] = 'öppna inventory',

  -- Salary related
  ['received_salary'] = 'du har mottagit din lön på ~g~%s SEK~s~',
  ['received_help'] = 'du har mottagit bidrag på ~g~%s SEK~s~',
  ['company_nomoney'] = 'företaget du är anställt hos har inte råd att betala ut din lön',
  ['received_paycheck'] = 'mottagit lön',
  ['bank'] = 'bank',
  ['account_bank'] = 'bank',
  ['account_black_money'] = 'svarta pengar',
  ['account_money'] = 'kontakter',

  ['act_imp'] = 'åtgärd omöjlig',
  ['in_vehicle'] = 'du kan inte ge saker till en som sitter i ett fordon!',

  -- Commands
  ['command_car'] = 'spawna ett fordon',
  ['command_car_car'] = 'namn på fordon eller hash',
  ['command_cardel'] = 'radera fordon i närheten',
  ['command_cardel_radius'] = 'valfri, radera alla fordon inom den angivna radien',
  ['command_clear'] = 'töm chatten',
  ['command_clearall'] = 'töm chatten för alla spelare',
  ['command_clearinventory'] = 'töm en spelares inventory',
  ['command_clearloadout'] = 'töm en spelares loadout',
  ['command_giveaccountmoney'] = 'ge pengar för ett konto',
  ['command_giveaccountmoney_account'] = 'giltigt kontonamn',
  ['command_giveaccountmoney_amount'] = 'mängd att ge',
  ['command_giveaccountmoney_invalid'] = 'kontonamnet är ej giltigt',
  ['command_giveitem'] = 'ge ett item till en spelare',
  ['command_giveitem_item'] = 'itemnamn',
  ['command_giveitem_count'] = 'mängd av itemet',
  ['command_giveweapon'] = 'ge ett vapen till en spelare',
  ['command_giveweapon_weapon'] = 'vapennamn',
  ['command_giveweapon_ammo'] = 'hur mycket ammo att ge',
  ['command_giveweapon_hasalready'] = 'spelaren har redan ett sådant vapen',
  ['command_giveweaponcomponent'] = 'ge vapen komponent',
  ['command_giveweaponcomponent_component'] = 'vapenkomponent',
  ['command_giveweaponcomponent_invalid'] = 'det vapenkomponentet är ej giltigt',
  ['command_giveweaponcomponent_hasalready'] = 'spelaren har redan det vapenkomponent',
  ['command_giveweaponcomponent_missingweapon'] = 'spelaren har ej det vapnet',
  ['command_save'] = 'spara en spelare i databas',
  ['command_saveall'] = 'spara alla spelare i databas',
  ['command_setaccountmoney'] = 'bestäm ny balans på ett spelarkonto',
  ['command_setaccountmoney_amount'] = 'ny balans',
  ['command_setcoords'] = 'teleportera till koordinater',
  ['command_setcoords_x'] = 'x axel',
  ['command_setcoords_y'] = 'y axel',
  ['command_setcoords_z'] = 'z axel',
  ['command_setteam'] = 'välj teamb för en spelare',
  ['command_setteam_team'] = 'teambnamn',
  ['command_setteam_grade'] = 'teambnivå',
  ['command_setteam_invalid'] = 'teambet, nivån eller båda är ej giltiga',
  ['command_setgroup'] = 'välj grupp åt en spelare',
  ['command_setgroup_group'] = 'gruppnamn',
  ['commanderror_argumentmismatch'] = 'argumentstorlek mismatch (gav %s, ville ha %s)',
  ['commanderror_argumentmismatch_number'] = 'argument #%s typ mismatch (gav string, ville ha number)',
  ['commanderror_invaliditem'] = 'ej giltigt item',
  ['commanderror_invalidweapon'] = 'ej giltigt vapen',
  ['commanderror_console'] = 'detta kommando kan ej executas i konsol',
  ['commanderror_invalidcommand'] = '^3%s^0 är inte ett giltigt kommando!',
  ['commanderror_invalidplayerid'] = 'det finns ingen spelare som matchar det angivna server id',
  ['commandgeneric_playerid'] = 'spelarid',

  -- Locale settings
  ['locale_digit_grouping_symbol'] = ' ',
  ['locale_currency'] = '%s SEK',

  -- Weapons
  ['weapon_knife'] = 'kniv',
  ['weapon_nightstick'] = 'batong',
  ['weapon_hammer'] = 'hammare',
  ['weapon_bat'] = 'slagträ',
  ['weapon_golfclub'] = 'golf club',
  ['weapon_crowbar'] = 'kofot',
  ['weapon_pistol'] = 'pistol',
  ['weapon_combatpistol'] = 'combat pistol',
  ['weapon_appistol'] = 'ap pistol',
  ['weapon_pistol50'] = 'pistol .50',
  ['weapon_microsmg'] = 'micro smg',
  ['weapon_smg'] = 'smg',
  ['weapon_assaultsmg'] = 'assault smg',
  ['weapon_assaultrifle'] = 'assault rifle',
  ['weapon_carbinerifle'] = 'carbine rifle',
  ['weapon_advancedrifle'] = 'advanced rifle',
  ['weapon_mg'] = 'mg',
  ['weapon_combatmg'] = 'combat mg',
  ['weapon_pumpshotgun'] = 'pump shotgun',
  ['weapon_sawnoffshotgun'] = 'sawed off shotgun',
  ['weapon_assaultshotgun'] = 'assault shotgun',
  ['weapon_bullpupshotgun'] = 'bullpup shotgun',
  ['weapon_stungun'] = 'elchockpistol',
  ['weapon_sniperrifle'] = 'prickskyttegevär',
  ['weapon_heavysniper'] = 'tung prickskytt',
  ['weapon_grenadelauncher'] = 'granatkastare',
  ['weapon_rpg'] = 'raketgevär',
  ['weapon_minigun'] = 'minigun',
  ['weapon_grenade'] = 'granat',
  ['weapon_stickybomb'] = 'klibbig bomb',
  ['weapon_smokegrenade'] = 'rökgranat',
  ['weapon_bzgas'] = 'bz gas',
  ['weapon_molotov'] = 'molotov cocktail',
  ['weapon_fireextinguisher'] = 'brandsläckare',
  ['weapon_petrolcan'] = 'bensindunk',
  ['weapon_ball'] = 'boll',
  ['weapon_snspistol'] = 'sns pistol',
  ['weapon_bottle'] = 'flaska',
  ['weapon_gusenberg'] = 'gusenberg sweeper',
  ['weapon_specialcarbine'] = 'special carbine',
  ['weapon_heavypistol'] = 'heavy pistol',
  ['weapon_bullpuprifle'] = 'bullpup rifle',
  ['weapon_dagger'] = 'dolk',
  ['weapon_vintagepistol'] = 'vintage pistol',
  ['weapon_firework'] = 'fyrverkeriraket',
  ['weapon_musket'] = 'musköt',
  ['weapon_heavyshotgun'] = 'heavy shotgun',
  ['weapon_marksmanrifle'] = 'marksman rifle',
  ['weapon_hominglauncher'] = 'homing launcher',
  ['weapon_proxmine'] = 'proximity mine',
  ['weapon_snowball'] = 'snöboll',
  ['weapon_flaregun'] = 'signalpistol',
  ['weapon_combatpdw'] = 'combat pdw',
  ['weapon_marksmanpistol'] = 'marksman pistol',
  ['weapon_knuckle'] = 'knogjärn',
  ['weapon_hatchet'] = 'yxa',
  ['weapon_railgun'] = 'railgun',
  ['weapon_machete'] = 'machete',
  ['weapon_machinepistol'] = 'machine pistol',
  ['weapon_switchblade'] = 'switchblade',
  ['weapon_revolver'] = 'heavy revolver',
  ['weapon_dbshotgun'] = 'double barrel shotgun',
  ['weapon_compactrifle'] = 'compact rifle',
  ['weapon_autoshotgun'] = 'auto shotgun',
  ['weapon_battleaxe'] = 'stridsyxa',
  ['weapon_compactlauncher'] = 'compact launcher',
  ['weapon_minismg'] = 'mini smg',
  ['weapon_pipebomb'] = 'pipe bomb',
  ['weapon_poolcue'] = 'biljardkö',
  ['weapon_wrench'] = 'skiftnyckel',
  ['weapon_flashlight'] = 'ficklampa',
  ['gadget_parachute'] = 'fallskärm',
  ['weapon_flare'] = 'blossa',
  ['weapon_doubleaction'] = 'double-Action Revolver',

  -- Weapon Components
  ['component_clip_default'] = 'standard magg',
  ['component_clip_extended'] = 'förlängd magg',
  ['component_clip_drum'] = 'trummagasin',
  ['component_clip_box'] = 'lådmagasin',
  ['component_flashlight'] = 'ficklampa',
  ['component_scope'] = 'sikte',
  ['component_scope_advanced'] = 'advancerat sikte',
  ['component_suppressor'] = 'ljuddämpare',
  ['component_grip'] = 'handtag',
  ['component_luxary_finish'] = 'lyxvapen behandling',

  -- Weapon Ammo
  ['ammo_rounds'] = 'ammunition',
  ['ammo_shells'] = 'hagel',
  ['ammo_charge'] = 'laddning',
  ['ammo_petrol'] = 'liter bensin',
  ['ammo_firework'] = 'fyrverkeri',
  ['ammo_rockets'] = 'raket',
  ['ammo_grenadelauncher'] = 'granat(er)',
  ['ammo_grenade'] = 'granat(er)',
  ['ammo_stickybomb'] = 'bomb(er)',
  ['ammo_pipebomb'] = 'bomb(er)',
  ['ammo_smokebomb'] = 'bomb(er)',
  ['ammo_molotov'] = 'cocktail(s)',
  ['ammo_proxmine'] = 'bomb(er)',
  ['ammo_bzgas'] = 'burk(ar)',
  ['ammo_ball'] = 'boll(ar)',
  ['ammo_snowball'] = 'snöboll(ar)',
  ['ammo_flare'] = 'lysraket(er)',
  ['ammo_flaregun'] = 'lysraket(er)',

  -- Weapon Tints
  ['tint_default'] = 'standardutseende',
  ['tint_green'] = 'grönskinn',
  ['tint_gold'] = 'guldskinn',
  ['tint_pink'] = 'råsaskinn',
  ['tint_army'] = 'arméskinn',
  ['tint_lspd'] = 'blåskinn',
  ['tint_orange'] = 'orangeskinn',
  ['tint_platinum'] = 'platinaskinn',
}
