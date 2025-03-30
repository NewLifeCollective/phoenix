-- Webhook for instapic posts, recommended to be a public channel
INSTAPIC_WEBHOOK = "https://discord.com/api/webhooks/"
-- Webhook for birdy posts, recommended to be a public channel
BIRDY_WEBHOOK = "https://discord.com/api/webhooks/"

-- Discord webhook for server logs
LOGS = {
    Default = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU", -- set to false to disable
    Calls = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Messages = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    InstaPic = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Birdy = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    YellowPages = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Marketplace = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Mail = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Wallet = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    DarkChat = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Services = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Crypto = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Trendy = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU",
    Uploads = "https://discord.com/api/webhooks/1352694820619157534/l6u19j153sErZtYg1rDSI6Og4_8H7vgp3utLTVBgrDZmTXwUJFWUDVfhOb3TwVhqcdwU" -- all camera uploads will go here
}

DISCORD_TOKEN = nil -- you can set a discord bot token here to get the players discord avatar for logs

-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default upload method is Fivemanage
-- We STRONGLY discourage using Discord as an upload method, as uploaded files may become inaccessible after a while.
-- You can get your API keys from https://fivemanage.com/
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = GetConvar("fivemanage_api_key", ""),
    Image = GetConvar("fivemanage_api_key", ""),
    Audio = GetConvar("fivemanage_api_key", ""),
}
