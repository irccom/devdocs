---
^title: "ACC IRC Command"
ntitle: "ACC"
nsub: "Register and validate new user accounts"
layout: command
experimental: true

command: ACC
related-commands:
    - AUTHENTICATE

examples: |
    ACC REGISTER dan mailto:dan@example.com passphrase :testpassphrase123
    ACC VERIFY dan 3qw4tq4te4gf34

supported-by:
    oragono: true
---
The `ACC` command allows users to register and validate new user accounts. It's defined [here](https://github.com/ircv3/ircv3-specifications/pull/276).

This is the syntax:
<pre class="code">
ACC REGISTER &lt;accountname&gt; [callback_ns:]&lt;callback&gt; [cred_type] :&lt;credential&gt;
ACC VERIFY
</pre>
