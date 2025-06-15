Config = {
    Announcement = {
        Command = "announce",
        AcePermission = "tcr_utility.Announce",
        Header = "~b~[~p~Server Announcement~b~]",
        Placement = 0.0, -- 0 for top, 0.3 for middle
        DisplayTime = 15 -- seconds
    },

    AOP = {
        Default = "North",
        Command = "aop",
        AcePermission = "tcr_utility.AOP"
    },
    Peacetime = {
        Command = "pt",
        AcePermission = "tcr_utility.Peacetime"
    },

    Priority = {
        Command = "prio",
        AcePermission = "tcr_utility.Priority",
        CooldownMinutes = 10,
        DefaultStatus = "Available"
    },
    AdminAce = "tcr_utility:BypassPeacetime"
}
