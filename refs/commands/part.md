---
title: "PART IRC Command"
ntitle: "PART"
nsub: "Leaves a channel"
layout: command

command: PART
command-groups:
    - channels
numerics:
    - "403"
    - "442"

format: |
    PART <channel>{,<channel>} [<reason>]

examples:
    - desc: Parting with no reason
      content: |
        C  ->  PART #irctest
        S <-   :d!d@localhost PART #irctest
    
    - desc: Parting with a reason
      content: |
        C  ->  part #irctest :I'm joined to too many channels already
        S <-   :alice!a@localhost PART #irctest :I'm joined to too many channels already
    
    - desc: Parting a channel you're not joined to
      content: |
        C  ->  PART #ircv3
        S <-   :irc.example.com 442 alice #ircv3 :You're not on that channel

    - desc: Parting two real channels, and a non-existent channel
      content: |
        C  ->  JOIN #alpha
        S <-   :patty!p@localhost JOIN :#alpha
        S <-   :irc.example.com 353 patty = #alpha :@patty
        S <-   :irc.example.com 366 patty #alpha :End of /NAMES list.
        C  ->  JOIN #charlie
        S <-   :patty!p@localhost JOIN :#charlie
        S <-   :irc.example.com 353 patty = #charlie :@patty
        S <-   :irc.example.com 366 patty #charlie :End of /NAMES list.
        C  ->  part #alpha,#beta,#charlie
        S <-   :patty!p@localhost PART #alpha
        S <-   :irc.example.com 403 patty #beta :No such channel
        S <-   :patty!p@localhost PART #charlie

    - desc: Parting two real channels
      content: |
        C  ->  part #alpha,#charlie
        S <-   :patty!p@localhost PART #alpha
        S <-   :patty!p@localhost PART #charlie

    - desc: Seeing someone else part a channel
      content: |
        C  ->  JOIN #irctoast
        S <-   :dan!d@localhost JOIN :#irctoast
        S <-   :irc.example.com 353 dan = #irctoast :dan @alice
        S <-   :irc.example.com 366 dan #irctoast :End of /NAMES list.
        S <-   :alice!a@localhost PART #irctoast :Heading off!

supported-by-default: true

contributors:
    - doaks
---
The `PART` command indicates that the client wants to leave one or more channels. In response, the server sends one or more `PART` message to indicate that the request was successful.

-----

{% include command-format-header.html %}

- `<channel>`: Name of the channel(s) to join, separated by commas.
- `<reason>`: Optional reason which is shown to the other users in the channel.

A `PART` message sent from the server indicates that someone has left a channel. In this case, the `<prefix>` is the user that's left. If a user's `PART` command is successful, they receive one of these messages. In addition, all other clients in the channel also receive a `PART` message. For example, if `dan` and `alice` are on channel `#irctoast`, and `dan` parts, both of them will receive a `PART` message indicating that `dan` has left the channel. The examples illustrate this in action.

The channels are processed in order. If the channel exists and the user is joined to it, they are parted from the channel and send an appropriate `PART` message. If the channel exists and the user isn't joined to it, they are sent an `ERR_NOTONCHANNEL` reply and the server continues with the next channel. If the channel doesn't exist the user gets sent an `ERR_NOSUCHCHANNEL` reply and the server continues.

Some servers only use the `<reason>` after the client's been connected for a certain amount of time, to help prevent spam. 
