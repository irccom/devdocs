---
title: "NAMES IRC Command"
ntitle: "NAMES"
nsub: "Shows who's joined to channels"
layout: command

command: NAMES
command-groups:
    - channels
numerics:
    - "353"
    - "366"
    - "407"

format: |
    NAMES [<channel>{,<channel>}]

examples:
    - desc: "Running NAMES on a channel"
      content: |
        bob  -> NAMES #chan
        bob <-  :irc.example.com 353 bob = #chan :bob @dan 
        bob <-  :irc.example.com 366 bob #chan :End of /NAMES list.
    
    - desc: "Running NAMES on a channel with the `multi-prefix` client capability negotiated"
      content: |
        alice  -> NAMES #chan
        alice <-  :irc.example.com 353 alice = #chan :alice bob @+dan
        alice <-  :irc.example.com 366 alice #chan :End of /NAMES list.
    
    - desc: "Running NAMES with no parameter, while joined to a channel"
      content: |
        bob  -> NAMES
        bob <-  :irc.example.com 366 bob * :End of /NAMES list.
    
    - desc: "Running NAMES with no parameter, while joined to a channel"
      content: |
        bob  -> NAMES
        bob <-  :irc.example.com 353 bob = #chan :bob @dan
        bob <-  :irc.example.com 366 bob * :End of /NAMES list.

    - desc: "Running NAMES on a channel while not joined to it"
      content: |
        alice  -> NAMES #chan
        alice <-  :irc.example.com 366 alice #chan :End of /NAMES list.

    - desc: "Running NAMES on a channel while not joined to it"
      content: |
        alice  -> NAMES #chan
        alice <-  :irc.example.com 353 alice = #chan :
        alice <-  :irc.example.com 366 alice #chan :End of /NAMES list.

    - desc: "Running NAMES on a channel while not joined to it"
      content: |
        alice  -> NAMES #chan
        alice <-  :irc.example.com 353 alice = #chan :bob @dan
        alice <-  :irc.example.com 366 alice #chan :End of /NAMES list.

supported-by-default: true

contributors:
    - doaks
---
The `NAMES` command lets users see who is joined to the given channel(s).

-----

{% include command-format-header.html %}

- `<channel>`: Optional, one or more channel names separated by commas.

This command indicates that the client wants to see all users joined to the given channels, or every channel on the network if the parameter is not given. If no parameter is given, the server may either only return results for the channel(s) the user is joined to, or show no results at all (to prevent spamming or similar), so clients should always list the specific channels if they do want a response.

If too many channels are given in the parameter, the server returns a `ERR_TOOMANYTARGETS` numeric and the command fails. Some servers only process the first given channel and ignore all others.

If a given channel does not exist, the server will return zero `RPL_NAMREPLY` numerics for that channel.

If a given channel has the [secret](../modes/c/secret) flag set and the user running the `NAMES` command is not a member of the channel, the server will usually return zero `RPL_NAMREPLY` numerics (responding in the same way it would if channel did not exist). Most servers treat all channels in this way (or by returning the `RPL_NAMREPLY` numeric with an empty final parameter instead).

When responding to a `NAMES` command with no parameters, a few servers also respond with a `RPL_NAMREPLY` numeric with an asterisk (`*`) as both the `<symbol>` and `<channel>` parameters, so clients should handle this without error.

Servers may return more than one `RPL_NAMREPLY` numeric for a single channel, when the channel has more users than can be sent in a single numeric.

The server returns zero or more `RPL_NAMREPLY` numerics listing the users in the given channel, followed by one `RPL_ENDOFNAMES` numeric noting the end of the reply.
