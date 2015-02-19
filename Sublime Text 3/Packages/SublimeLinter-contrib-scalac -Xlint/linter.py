#
# linter.py
# Linter for SublimeLinter3, a code checking framework for Sublime Text 3
#
# Written by Hawk Weisman
# Copyright (c) 2014 Hawk Weisman
#
# License: MIT
#

"""This module exports the Scalac Xlint plugin class."""

from SublimeLinter.lint import Linter, util


class Scalac Xlint(Linter):

    """Provides an interface to scalac -Xlint."""

    syntax = ''
    executable = 'scalac'
    version_args = '--version'
    version_re = r'(?P<version>\d+\.\d+\.\d+)'
    version_requirement = '>= 1.0'
    regex = r''
    multiline = False
    line_col_base = (1, 1)
    tempfile_suffix = None
    error_stream = util.STREAM_BOTH
    selectors = {}
    word_re = None
    defaults = {}
    inline_settings = None
    inline_overrides = None
    comment_re = None

    def cmd(self):
        """
        Return the command line to execute.

        We override this because we have to munge the -Xlint argument
        based on the 'lint' setting.

        """
        xlint = '-Xlint'
        dp
