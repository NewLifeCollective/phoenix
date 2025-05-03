-- tcr_logger - A FiveM resource for NewLife Collective
-- Copyright (C) 2025 TheClassyR3dneck
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <https://www.gnu.org/licenses/>.

fx_version 'cerulean'
game 'gta5'

author 'TheClassyR3dneck'
description 'Relays in-game chat message to a Discord Channel'
version '1.0.0'

server_scripts {
    'server.lua'
}

dependency 'Badger_Discord_API'