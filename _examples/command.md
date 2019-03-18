---
# name of the command, followed by "IRC Command"
title: "EXAMPLE IRC Command"
# just the name of the command
ntitle: "EXAMPLE"
# sentence description of the command, shown as a subtitle
nsub: "Does whatever's described on this page"
# leave this alone, it's the jekyll template to use
layout: command

# name of the command again!
command: EXAMPLE
# any command groups that are appropriate
command-groups:
    - any
    - applicable
    - groups
# numerics returned by the command (success, failure, etc)
numerics:
    - "001"
    - "002"
    - "003"

# the format of the command, in a simplified way
format: |
    EXAMPLE [<format>] <goes> <here>

# real-world examples of the command in use
examples:
    - desc: First example
      content: |
        C  ->  EXAMPLE works like this
        S <-   :irc.example.com 001 .. .. ..

    - desc: Second example
      content: |
        C  ->  example also :works in this way
        S <-   :irc.example.com 002 .. .. ..
        S <-   :irc.example.com 003 .. .. ..

# if the command is supported by all servers, use this:
supported-by-default: true
# if the command isn't supported by everything, instead list the ircds here:
supported-by:
    unreal: true
    inspircd: true
    hybrid: true

# list of people who have written, edited, or otherwise contributed to this page
contributors:
    - doaks
---
The `EXAMPLE` command does whatever's described here. This is a one-paragraph explanation of the command, before the text below dives into specifics.

-----

{% include command-format-header.html %}

- `<format>`: This is an optional parameter that indicates A, B, and C.
- `<goes>`: This is a mandatory parameter that indicates D, E, and F.
- `<here>`: This is a mandatory parameter that indicates X, Y, and Z.

If the user doesn't have the permission to run this command, the `ERR_BLAHBLAH` response is sent and the command fails.

If the `<format>` parameter is omitted, the server assumes that the target is the user who sent the command.

If the command is successful, the server sends a `NOTE` back to the user (as shown in the examples below).

This section describes, in detail, how the command responds in each case, and what each parameter means (along with whether those parameters are optional or mandatory).
