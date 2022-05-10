Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', '~r~Cars ~s~ Freeroam ~t~ | ~r~ID : ~s~'.. GetPlayerServerId(PlayerId()) .. ' ~t~ | ~r~ Nom : ~s~' .. GetPlayerName(PlayerId())) -- Texte Menu

    AddTextEntry('PM_SCR_MAP', '~r~Carte') -- Texte Catégorie Map
    AddTextEntry('PM_SCR_GAM', '~s~ Jeu') -- Texte Catégorie Jeu
    AddTextEntry('PM_SCR_INF', '~r~ Informations') -- Texte Catégorie Info
    AddTextEntry('PM_SCR_STA', '~s~ Statistiques') -- Texte Catégorie Statistiques
    AddTextEntry('PM_SCR_SET', '~r~ Paramètres') -- Texte Catégorie Paramètres
    AddTextEntry('PM_SCR_GAL', '~s~ Galerie') -- Texte Catégorie Galerie
    AddTextEntry('PM_SCR_RPL', '~r~ Editeur Rockstar') -- Texte Catégorie Rockstar Editor
  end)