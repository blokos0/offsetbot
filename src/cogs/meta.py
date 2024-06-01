from __future__ import annotations

import asyncio
import colorsys
import os
import typing
from copy import copy
from functools import reduce
import itertools
from datetime import datetime
from glob import glob
from inspect import Parameter
from pathlib import Path
from subprocess import PIPE, STDOUT, TimeoutExpired, run
from time import time
from typing import Optional, Sequence

import re

import discord
from discord.ext import commands, menus
from discord.ext.commands import Command

from ..types import Bot, Context
from ..utils import ButtonPages


class CommandPageSource(menus.ListPageSource):
    def __init__(self, data: Sequence[tuple[Command]]):
        data = copy(data)  # Just to be safe
        new_data = list(data)
        for i, command in enumerate(data):
            if isinstance(command, commands.Group) and not command.hidden and command.name != "jishaku":
                children = []
                for child in command.commands:
                    child = child.copy()
                    child.name = f"{command.name} {child.name}"
                    child.aliases = tuple(f"{command.name} {alias}" for alias in child.aliases)
                    children.append(child)
                new_data[i + 1:i + 1] = children
        super().__init__(new_data, per_page=1)

    async def format_page(self, menu: menus.Menu, entry: Command) -> discord.Embed:
        arguments = ""
        for name, param in entry.params.items():
            arguments += name
            if param.annotation:
                arguments += ": "
                if typing.get_origin(param.annotation) == typing.Literal:
                    arguments += str([arg for arg in typing.get_args(param.annotation)])
                else:
                    arguments += param.annotation.__name__
            if param.default is not Parameter.empty:
                arguments += f" = {repr(param.default)}"
            arguments += ", "
        arguments = arguments.rstrip(", ")
        embed = discord.Embed(
            color=menu.bot.embed_color,
            title=entry.name,
            description=(f"> _aka {', '.join(entry.aliases)}_\n" if len(entry.aliases) else "") +
                        f"> Arguments: `{arguments}`\n" if len(arguments) else ""
        )
        if entry.help is not None:
            help = copy(entry.help)
            while len(help) > 0:
                embed.add_field(
                    name="",
                    value=help[:1024],
                    inline=False
                )
                help = help[1024:]
        embed.set_footer(text=f"{menu.current_page + 1}/{self.get_max_pages()}")
        return embed


class DocsPageSource(menus.ListPageSource):
    def __init__(self):
        docs = []
        for path in sorted(glob("docs/*.md")):
            with open(path, "r") as f:
                match = re.fullmatch(r".+? - (.+)", Path(path).stem)
                assert match is not None, "One or more of the documentation files are invalid! Please contact the owner."
                title = match.group(1)
                docs.append((title, f.read()))
        super().__init__(docs, per_page=1)

    async def format_page(self, menu: menus.Menu, entry: tuple[str, str]) -> discord.Embed:
        title, description = entry
        embed = discord.Embed(
            color=menu.bot.embed_color,
            title=title,
            description=description
        )
        embed.set_footer(text=f"Page {menu.current_page + 1} of {self.get_max_pages()}")
        return embed


class MetaCog(commands.Cog, name="Other Commands"):
    def __init__(self, bot: Bot):
        self.bot = bot

    # Check if the bot is loading
    async def cog_check(self, ctx: Context):
        return not self.bot.loading

    @commands.command(aliases=["pong"])
    @commands.cooldown(5, 8, commands.BucketType.channel)
    async def ping(self, ctx: Context):
        """Returns bot latency."""

        pingns = int(self.bot.latency * 1000)

        await ctx.send(embed=discord.Embed(
            title="latency (i apologize for my internet)",
            color=self.bot.embed_color,
            description=f"{pingns} ms"))

    @commands.command(aliases=["commands"])
    @commands.cooldown(4, 8, type=commands.BucketType.channel)
    async def cmds(self, ctx: Context, query: Optional[str] = None):
        """Lists the bot's commands. You are here!
    Commands can be specified through a regular expression."""
        new_query = query
        if query is None or query == "list":
            new_query = ""
        owner = await ctx.bot.is_owner(ctx.author)
        cmds = sorted((cmd for cmd in self.bot.commands if
                       re.match(new_query, cmd.name) and (not cmd.hidden or owner)),
                      key=lambda cmd: cmd.name)
        if query == "list":
            names = [cmd.name for cmd in cmds]
            nl = "\n"
            return await ctx.send(f"""```
{nl.join(names)}```""")
        assert len(cmds) > 0, f"No commands found for the query `{query}`!"
        await ButtonPages(
            source=CommandPageSource(
                cmds
            ),
        ).start(ctx)

    @commands.command(aliases=["about", "info"])
    @commands.cooldown(4, 8, type=commands.BucketType.channel)
    async def help(self, ctx: Context, query: Optional[str] = None):
        """Directs new users on what they can do and where they can go."""
        if query is not None:
            return await ctx.invoke(self.bot.get_command("cmds"), query=query)
        embed = discord.Embed(
            title="OFFSETBOT",
            color=self.bot.embed_color
        )
        embed.add_field(
            name="",
            value="""welcome to the bot! (not really my bot, more like a mod of robot is chill) 
this help page should be able to guide you to everything you need to know
- if you need a list of tiles you can use, look through `search`
- if you need a list of commands, look at `commands`
- if you need to make a render, look at `commands tile`
- if you need to be ashamed, look at `hints` (there are no hints)
- if you need to look at a level, look at `level` (there are no levels yet)
- if you need help learning how to make renders, look at `docs`""",
            inline=False
        )
        ut = (datetime.utcnow() - self.bot.started).seconds
        async with self.bot.db.conn.cursor() as cur:
            await cur.execute("SELECT COUNT(DISTINCT name) FROM tiles")
            tile_amount = (await cur.fetchone())[0]
        days, remainder = divmod(ut, 86400)
        hours, remainder = divmod(remainder, 3600)
        minutes, seconds = divmod(remainder, 60)
        embed.add_field(
            name="Statistics",
            value=f"""guilds (fancy term for servers): {len(self.bot.guilds)}/100
channels: {sum(len(g.channels) for g in self.bot.guilds)}
uptime: {days}:{hours:02}:{minutes:02}:{seconds:02}
tiles: {tile_amount}""",
            inline=True
        )
        embed.add_field(
            name="Developers",
            value="""_@blokos_ - dev
_@balt_ - creator of robot is chill
_@gabeyk9_ - helped a lot
""",
            inline=True
        )
        embed.add_field(
            name="Links",
            value="""[offset server](https://discord.gg/cbUMDFnGWb)\n[robot is chill server](https://discord.gg/ktk8XkAfGD)\n[source code](https://github.com/blokos0/offsetbot)""",
            inline=True
        )
        await ctx.send(embed=embed)

    @commands.command(aliases=["docs"])
    async def doc(self, ctx: Context, page: int = 0):
        """Get a tutorial on how to use the bot."""
        source = DocsPageSource()
        pages = ButtonPages(source=source)
        if not isinstance(ctx.channel, discord.DMChannel):
            await ctx.reply("Sending docs to DMs...")
        ctx.channel = await ctx.author.create_dm()
        await pages.start(ctx)
        await pages.show_page(page)


async def setup(bot: Bot):
    await bot.add_cog(MetaCog(bot))
