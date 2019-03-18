---
title: "ADDMOTD IRC Command"
ntitle: "ADDMOTD"
nsub: "Adds a line to the end of the Message of the Day"
layout: command

command: ADDMOTD
command-groups:
    - motd
numerics:
    - "461"
    - "481"

format: |
    ADDMOTD <text>

examples:
    - desc: Adding text to the MOTD
      content: |
        C  ->  addmotd :Be nice!
        S <-   :irc.example.com NOTICE dan :*** Wrote (Be nice!) to file: ircd.motd

    - desc: Adding an empty line to the MOTD
      content: |
        C  ->  addmotd :
        S <-   :irc.example.com NOTICE dan :*** Wrote () to file: ircd.motd

supported-by:
    unreal: true

contributors:
    - doaks
---
The `ADDMOTD` command allows operators to add text to the end of the Message of the Day (MOTD) file. When users view the MOTD (either in the connection registration burst, or with the `MOTD` command), they will see the new text.

-----

{% include command-format-header.html %}

- `<text>`: The text to add to the end of the MOTD. This can be empty (to add a blank line), but the parameter must exist.

If the user doesn't have the permission to add lines to the MOTD, the `ERR_NOPRIVILEGES` response is sent and the command fails.

If the last parameter is omitted, the `ERR_NEEDMOREPARAMS` response is sent and the command fails.

If the command is successful, the current server implementation sends a `NOTICE` back to the user (as shown in the examples below).
