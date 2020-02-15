# `pbsecret` #

    Usage: pbsecret [-hv]
    
       -v: print version and exit
       -h: print this help message and exit
    
    Copies data from STDIN to the general pasteboard as UTF-8 text. Copied
    data is tagged with "org.nspasteboard.ConcealedType" to prevent it from
    being saved in the history of a clipboard manager, as per the spec at:
    [http://nspasteboard.org/](http://nspasteboard.org/)

# Author #

Dustin Goldman, [dusto@goldmans.net](mailto:dusto@goldmans.net)
