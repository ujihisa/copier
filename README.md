# Copier

    $ gem install copier

## Usage

Usage 1: as a command

    $ copier 'hello'
    $ echo 'hello' | copier

Usage 2: as a library

    require 'copier'
    Copier('text')

run the code and then you can paste `text` by Cmd-v on Mac OS X, Ctrl-v on Windows, and as well on other platforms.

there's no paster command or method intentionally.

## Platform

This library supports the following platforms. I'm always welcome patches for supporting other platforms, including spec.

* Mac OS X
* Windows (cygwin)

## development

issues

* no GNOME support yet
* no KDE support yet
