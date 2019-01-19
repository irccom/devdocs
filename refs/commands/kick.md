---
title: "KICK IRC Command"
ntitle: "KICK"
nsub: "Removes a user from a channel"
layout: command

command: KICK
command-groups:
    - channels
numerics:
    - "401"
    - "403"
    - "441"
    - "442"
    - "476"
    - "482"
    - "482"

format: |
    KICK <channel> <nick> [<reason>]

examples:
    - desc: "`dan` kicking a user with no reason given"
      content: |
        S <-   :alice!a@localhost JOIN :#Melbourne
        C  ->  KICK #Melbourne alice
        S <-   :dan!d@localhost KICK #Melbourne alice :dan

    - desc: "`alice` getting kicked with no reason given"
      content: |
        C  ->  JOIN #test
        S <-   :alice!a@localhost JOIN :#test
        S <-   :irc.example.com 353 alice = #test :alice @dan
        S <-   :irc.example.com 366 alice #test :End of /NAMES list.
        S <-   :dan!d@localhost KICK #test alice :dan

    - desc: "`dan` kicking a user with a reason"
      content: |
        S <-   :alice!a@localhost JOIN :#test
        C  ->  kick #test alice :nah mate
        S <-   :dan!d@localhost KICK #test alice :nah mate

    - desc: "`alice` getting kicked with a reason given"
      content: |
        C  ->  join #test
        S <-   :alice!a@localhost JOIN :#test
        S <-   :irc.example.com 353 alice = #test :alice @dan
        S <-   :irc.example.com 366 alice #test :End of /NAMES list.
        S <-   :dan!d@localhost KICK #test alice :nah mate

    - desc: "`alice` kicking with no permissions"
      content: |
        C  ->  JOIN #test
        S <-   :alice!a@localhost JOIN :#test
        S <-   :irc.example.com 353 alice = #test :alice @dan
        S <-   :irc.example.com 366 alice #test :End of /NAMES list.
        C  ->  KICK #test dan
        S <-   :irc.example.com 482 alice #test :You're not channel operator

    - desc: "`dan` kicking a user that does not exist, and a user that isn't on the channel"
      content: |
        C  ->  JOIN #v3
        S <-   :dan!d@Clk-830D7DDC JOIN :#v3
        S <-   :irc.example.com 353 dan = #v3 :@dan
        S <-   :irc.example.com 366 dan #v3 :End of /NAMES list.
        C  ->  KICK #v3 tom
        S <-   :irc.example.com 401 dan tom :No such nick/channel
        C  ->  KICK #v3 jerry
        S <-   :irc.example.com 441 dan jerry #v3 :They aren't on that channel

supported-by-default: true

contributors:
    - doaks
---
The `KICK` command lets a channel operator remove a user from their channel.

-----

{% include command-format-header.html %}

- `<channel>`: Channel to kick the user from.
- `<nick>`: Nickname of the user to kick.
- `<reason>`: An optional reason to give the user (and everyone else in the channel).

Some server software allows you to specify multiple channels or nicknames by separating them with commas (e.g. `KICK #v3 tom,jerry`). However, this is not universally supported so stick to one channel and nick per kick command.

A `KICK` message sent from the server indicates that someone has been kicked. In this case, the `<prefix>` is the user who performed the kick. If a user's `KICK` command is successful, they receive one of these messages. In addition, the user who was kicked, and all other clients in the channel, also receive a `KICK` message. For example, if `dan`, `alice`, and `matthew` are on channel `#v4`, and `dan` kicks `matthew`, all three clients will receive a `KICK` message indicating that `dan` has removed `matthew` from the channel.

Multiple channels or nicknames may be specified, and clients perform the requests one at a time (returning only one channel/nick in each `KICK` message they send out). This is displayed in the examples below.

The `KICK` command is restricted to channel operators, and sometimes alternate permission levels added to the server (such as halfop).

If the user performing the kick does not have appropriate permissions, the server returns `ERR_CHANOPRIVSNEEDED` and continues. If the channel name is entirely invalid (does not start with `#`, etc), the server may return `ERR_BADCHANMASK` (or more likely will just return `ERR_NOSUCHCHANNEL`). If the user to be kicked isn't on the network, the chanop is sent `ERR_NOSUCHNICK`. If the user to be kicked exists but is not on the channel, the chanop is sent `ERR_USERNOTINCHANNEL`. And if the channel does not exist, `ERR_NOSUCHCHANNEL` is returned.
