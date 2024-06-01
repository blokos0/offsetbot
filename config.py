import discord

activity = "booting..."
description = "fork of ric for messing around"
prefixes = ["="]
trigger_on_mention = True
embed_color = 0x731CFF
logging_color = 0xFFFFFF
auth_file = "config/auth.json"
log_file = "log.txt"
db_path = "robot.db"
cogs = [
	"src.cogs.owner",
	"src.cogs.global",
	"src.cogs.meta",
	"src.cogs.errorhandler",
	"src.cogs.reader",
	"src.cogs.render",
	"src.cogs.variants",
	"src.cogs.utilities",
	"src.cogs.event",
	"src.cogs.flags",
	"src.cogs.macro_commands",
	"src.cogs.macros",
	"jishaku"
]
danger_mode = False
debug = False
owner_only_mode = [False,'']
