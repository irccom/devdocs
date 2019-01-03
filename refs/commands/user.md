---
title: "USER IRC Command"
ntitle: "USER"
nsub: "Set username and realname"
layout: command

command: USER
command-groups:
    - welcome
numerics:
    - "461"
    - "462"

format: |
    USER <username> 0 * <realname>

examples:
    - desc: Setting username, and username as seen by another user
      content: |
        C1  ->  nick alice
        C1  ->  user ali 0 * :My name is
        S1 <-   :irc.example.com 001 alice :Welcome to the ExampleNet Internet Relay Chat Network alice
        S1 <-   <connection burst>
        C1  ->  PRIVMSG ben :What's the password?

        S2 <-   :alice!~ali@localhost PRIVMSG ben :What's the password?

    - desc: Username retrieved with Ident, as seen by another user
      content: |
        C1  ->  nick alice
        C1  ->  user ali 0 * :My name is
        S1 <-   :irc.example.com 001 alice :Welcome to the ExampleNet Internet Relay Chat Network alice
        S1 <-   <connection burst>
        C1  ->  PRIVMSG ben :What's the password?

        S2 <-   :alice!uid21341@localhost PRIVMSG ben :What's the password?

    - desc: Attempting USER after connection registration has completed
      content: |
        C  ->  USER ger 0 * :I want to change my gecos!
        S <-   :irc.example.com 462 alice :You may not reregister
    
    - desc: USER with no `<realname>` parameter
      content: |
        C  ->  NICK alice
        C  ->  USER ali 0 *
        S <-   :irc.example.com 461 alice USER :Not enough parameters

supported-by-default: true

contributors:
    - doaks
---
The `USER` command lets a user set their username and realname while connecting to the server. This command cannot be used after connection registration has completed.

-----

{% include command-format-header.html %}

- `<username>`: The username to set (i.e. the `user` part of their `nick!user@host`).
- `<realname>`: The realname (or _gecos_) to set. May contain spaces.

The `<username>` submitted is the one the client prefers, but servers may silently modify or truncate it before setting it on the user. The maximum length of the username may be specified by the [`USERLEN` 005 parameter](../isupport/005).

Some servers set the username of connecting clients automatically by relying on the [Ident Protocol](http://tools.ietf.org/html/rfc1413). In these servers, the username retrieved via Ident is preferred over the one submitted by the client. When connecting to these servers, if the submitted `<username>` is used, it will commonly be prefixed with a tilde (`~`) to indicate that it's user-set.

The second and third parameters have different definitions depending on the source you refer to, and the software the server is running. To prevent any unexpected results, we recommend always sending a zero (`0`) and an asterisk (`*`) for these parameters.

If a client tries to sent the `USER` command after connection registration has been completed, the `ERR_ALREADYREGISTRED` reply is sent and the command is ignored.
