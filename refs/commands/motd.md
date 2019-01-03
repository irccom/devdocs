---
title: "MOTD IRC Command"
ntitle: "MOTD"
nsub: "Shows the current Message of the Day"
layout: command

command: MOTD
command-groups:
    - welcome
    - motd
numerics:
    - "402"
    - "422"
    - "375"
    - "372"
    - "376"

format: |
    MOTD [<server>]

examples:
    - desc: Typical MOTD command usage for the current server
      content: |
        C  ->  MOTD
        S <-   :irc.example.com 375 chris :- irc.example.com Message of the Day -
        S <-   :irc.example.com 372 chris :- ExampleNet is a really cool network!
        S <-   :irc.example.com 372 chris :- No spamming please, thank you!
        S <-   :irc.example.com 376 chris :End of /MOTD command.
    
    - desc: MOTD for a specific server
      content: |
        C  ->  MOTD dan.irc.example.com
        S <-   :dan.irc.example.com 375 chris :- dan.irc.example.com Message of the Day -
        S <-   :dan.irc.example.com 372 chris :- This is dan's ExampleNet server! You can spam here
        S <-   :dan.irc.example.com 372 chris :- if you want, just be nice.
        S <-   :dan.irc.example.com 376 chris :End of /MOTD command.

    - desc: MOTD for a nonexistent server
      content: |
        C  ->  MOTD terry.irc.example.com
        S <-   :irc.example.com 402 chris terry.irc.example.com :No such server

    - desc: Welcome burst with missing MOTD
      content: |
        C  ->  nick jen
        C  ->  USER j 0 * :Whoo me!
        S <-   :irc.example.com 001 jen :Welcome to the ExampleNet Internet Relay Chat Network jen
        S <-   :irc.example.com 002 jen :Your host is irc.example.com[0::/6667], running version kittenircd34.4
        S <-   :irc.example.com 003 jen :This server was created Mon Dec 3 2018 at 16:37:50 AEST
        S <-   :irc.example.com 004 jen irc.example.com kittenircd34.4 DQRSZagiloswz CFILPQbcefgijklmnopqrstvz bkloveqjfI
        S <-   :irc.example.com 005 jen SAFELIST ELIST=CTU MONITOR=100 WHOX CHANTYPES=#& EXCEPTS INVEX CHANMODES=eIbq,k,flj,CFLPQcimnprst CHANLIMIT=#&:15 :are supported by this server
        S <-   :irc.example.com 005 jen PREFIX=(ov)@+ MAXLIST=bqeI:100 NETWORK=ExampleNet STATUSMSG=@+ CASEMAPPING=rfc1459 NICKLEN=30 MAXNICKLEN=31 CHANNELLEN=50 TOPICLEN=390 :are supported by this server
        S <-   :irc.example.com 005 jen TARGMAX=NAMES:1,LIST:1,KICK:1,WHOIS:1,PRIVMSG:4,NOTICE:4,ACCEPT:,MONITOR: CLIENTVER=3.0 :are supported by this server
        S <-   :irc.example.com 251 jen :There are 0 users and 1 invisible on 1 servers
        S <-   :irc.example.com 255 jen :I have 1 clients and 0 servers
        S <-   :irc.example.com 265 jen 1 1 :Current local users 1, max 1
        S <-   :irc.example.com 266 jen 1 1 :Current global users 1, max 1
        S <-   :irc.example.com 250 jen :Highest connection count: 1 (1 clients) (1 connections received)
        S <-   :irc.example.com 422 jen :MOTD File is missing

supported-by-default: true

contributors:
    - doaks
---
The `MOTD` command returns the current Message of the Day (MOTD) set on the server. The server's MOTD is totally freeform and set by the administrator of the server. It typically includes a description of the server itself, the network the server's a part of, and a list of rules to follow while connected.

In addition, at the end of the connection registration burst, the MOTD is automatically sent to the client (either the `RPL_MOTDSTART`, `RPL_MOTD`, and `RPL_ENDOFMOTD` responses, or alternatively the `ERR_NOMOTD` response).

-----

{% include command-format-header.html %}

- `<server>`: If included, which server's MOTD to show. If omitted, defaults to the current server.

If `<server>` is given but that server cannot be found, a `ERR_NOSUCHSERVER` response is sent and the command fails.

If the MOTD is found, one `RPL_MOTDSTART` response is sent, followed by one or more `RPL_MOTD` responses, and then one final `RPL_ENDOFMOTD` response.

If the MOTD does not exist on the server, the `ERR_NOMOTD` response is sent.
