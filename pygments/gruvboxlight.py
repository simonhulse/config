#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygments.style import Style
from pygments.token import (
    Comment,
    Error,
    Escape,
    Generic,
    Keyword,
    Literal,
    Name,
    Number,
    Operator,
    Other,
    Punctuation,
    String,
    Text,
    Token,
    Whitespace,
)

try:
    from IPython.core.getipython import get_ipython
except ImportError:
    shell = None
else:
    shell = get_ipython()

__all__ = ["GruvboxlightStyle"]


class GruvboxlightStyle(Style):
    BACKGROUND = "#fbf1c7"
    CURRENT_LINE = "#3c3836"
    SELECTION = "#a89984"
    FOREGROUND = "#3c3836"
    COMMENT = "#928374"

    BRIGHT_RED = "#9d0006"
    RED = "#cc241d"
    ORANGE = "#af3a03"
    YELLOW = "#b57614"
    GREEN = "#79740e"
    AQUA = "#427b58"
    BLUE = "#076678"
    PURPLE = "#8f3f71"

    default_style = FOREGROUND
    background_color = BACKGROUND
    highlight_color = SELECTION

    styles = {
        Comment: COMMENT,  # class: 'c'
        Comment.Hashbang: COMMENT,
        Comment.Multiline: COMMENT,  # class: 'cm'
        # cython's IF DEF etc
        Comment.Preproc: f"noinherit {AQUA}",  # class: 'cp'
        Comment.Single: COMMENT,  # class: 'c1'
        # Comment.Special: "",  # class: 'cs'
        # `:hi pythonEscape`
        Escape: ORANGE,
        Error: BRIGHT_RED,  # class: 'err'
        Generic: FOREGROUND,  # class: 'g'
        Generic.Deleted: f"noinherit {BRIGHT_RED}",  # class: 'gd',
        Generic.Emph: f"italic {FOREGROUND}",  # class: 'ge'
        Generic.Emphasis: f"italic {FOREGROUND}",  # class: 'ge'
        Generic.Error: BRIGHT_RED,  # class: 'gr'
        Generic.Heading: f"bold {RED}",  # class: 'gh'
        Generic.Inserted: f"noinherit {GREEN}",  # class: 'gi'
        Generic.Output: "italic ",  # class: 'go'
        Generic.Prompt: f"bold {COMMENT}",  # class: 'gp'
        Generic.Strong: "bold ",  # class: 'gs'
        Generic.Subheading: f"bold {GREEN}",  # class: 'gu'
        # This is the text before the traceback
        Generic.Traceback: FOREGROUND,  # class: 'gt'
        # Note: In Pygments, Token.String is an alias for Token.Literal.String,
        #       and Token.Number as an alias for Token.Literal.Number.
        Literal: BLUE,  # class: 'l'
        Literal.Date: f"noinherit {GREEN}",  # class: 'ld'
        Literal.Number: PURPLE,  # class      : 'm'
        Literal.Number.Bin: PURPLE,
        Literal.Number.Float: PURPLE,  # class      : 'mf'
        Literal.Number.Hex: PURPLE,  # class      : 'mh'
        Literal.Number.Integer: PURPLE,  # class      : 'mi'
        Literal.Number.Integer.Long: PURPLE,  # class      : 'il'
        Literal.Number.Oct: PURPLE,  # class      : 'mo'
        Literal.String.Heredoc: GREEN,  # class: 'sh'
        Literal.String.Other: GREEN,  # class: 'sx'
        Literal.String.Regex: GREEN,  # class: 'sr'
        Literal.String.Single: GREEN,  # class: 's1'
        Literal.String.Symbol: GREEN,  # class: 'ss'
        # basically the foundation of everything
        Keyword: RED,  # class: 'k'
        Keyword.Declaration: AQUA,  # class: 'kd'
        # from <---- x import y
        Keyword.Namespace: f"noinherit {BLUE}",  # class: 'kn'
        # Keyword.Pseudo: "nobold",  # + GREEN,  # class: 'kp'
        Keyword.Pseudo: f"italic {GREEN}",  # class: 'kp'
        # Keyword.Reserved: "",  # class: 'kr'
        Keyword.Type: f"nobold {YELLOW}",  # class: 'kt'
        Name: f"noinherit {FOREGROUND}",  # class: 'n'
        Name.Attribute: f"noinherit {BLUE}",  # class: 'na'
        # Builtin functions like max, zip, min
        Name.Builtin: f"noinherit {YELLOW}",  # class: 'nb'
        # raise None <---
        Name.Builtin.Pseudo: f"noinherit {ORANGE}",  # class: 'bp'
        # So these should be coming up aqua. Why are they orange...?
        # Note it's only the clas name not the word class
        # class FooBar <-----
        Name.Class: AQUA,  # class: 'nc'
        Name.Constant: f"noinherit {BRIGHT_RED}",  # class: 'no'
        # Only the @ in a decorator
        Name.Decorator: f"bold {BRIGHT_RED}",  # class: 'nd'
        Name.Entity: AQUA,  # class: 'ni'
        Name.Exception: f"noinherit {PURPLE}",  # class: 'ne'
        # You guessed it
        Name.Function: f"noinherit {AQUA}",  # class: 'nf'
        # Dunders
        Name.Function.Magic: f"noinherit {AQUA}",
        # import mod <----
        Name.Namespace: FOREGROUND,  # class: 'nn'
        Name.Other: BLUE,  # class: 'nx'
        # Name.Property: "",  # class: 'py'
        Name.Tag: f"bold {AQUA}",  # class: 'nt'
        Name.Variable: BRIGHT_RED,  # class: 'nv'
        Name.Variable.Class: f"noinherit bold {BLUE}",  # class: 'vc'
        Name.Variable.Global: "italic",  # class: 'vg'
        # Instance dunders
        Name.Variable.Magic: f"noinherit {AQUA}",
        Name.Variable.Instance: "italic",  # class: 'vi'
        Operator: ORANGE,  # class: 'o'
        Operator.Word: RED,  # class: 'ow'
        # Can be the text in a traceback
        Other: FOREGROUND,  # class 'x'
        # Might be better suited as Delimiter. *Blue. Or Aqua?* nah
        Punctuation: FOREGROUND,  # class: 'p'
        String: GREEN,  # class: 's'
        String.Affix: f"{GREEN} underline",
        String.Backtick: GREEN,  # class: 'sb'
        String.Char: FOREGROUND,  # class: 'sc'
        String.Doc: f"italic {GREEN}",  # class: 'sd'
        String.Double: GREEN,  # class: 's2'
        String.Escape: f"bold {ORANGE}",  # class: 'se'
        # the old style '%s' % (...) string formatting
        String.Interpol: f"noinherit {ORANGE}",  # class: 'si'
        # No corresponding class for the following:
        Text: FOREGROUND,  # class:  ''
        Text.Whitespace: BRIGHT_RED,  # class: 'w'
        Token: ORANGE,
    }

    style_rules = styles

    def __repr__(self):
        return "%r" % (self.__class__.__name__)

    def __iter__(self):
        """Iter needs to be defined for use with pygments formatters."""
        return iter(self.style_rules.items())

    def dict_to_list_of_tuples(self, dictionary):
        tmp = []
        for i, j in dictionary.items():
            tmp.append((i, j))
        return tmp

    def _styles(self):
        return self.dict_to_list_of_tuples(self.style_rules)

    def __str__(self):
        return "%s" % (self.__class__.__name__)
