For small memory embedded use, replace the L2 cache with ram by hacking the tag and feed cache misses to the bus directly to l1 cache.
To do this it is needed to change the cache_condroller as well.
