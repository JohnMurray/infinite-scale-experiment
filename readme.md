# Infinite Scale Experiment

This is an experiments in design about how to develop applications
when operating at _near infinite scale_. This is based of off a [white-
paper][1] from Amazon by Pat Helland.

Nothing in this is _"production ready"_ and should be taken for what it is,
an experiment. If you have any fun thoughts or questions about any of this,
feel free to email me `me at johnmurray dot io`.


## Project Layout (tentative)

This project is broken down into phases, or _steps_, each with its own
directory. Breifly, these are:

### Phase 1

+ Individual Service (Campaign)
+ Service/Data Sharding (keys required on _all_ operations)
+ Simple Service Locater (routing)
+ Manual shard configuration (router-level)
+ Dynamic shard configuration (campaign-level)


### Phase 2 (the awkward years)

+ Improved key-range functionality
+ Router-layer to create POST ids
+ Server registration on startup
+ Dynamic shard configuration (router-level) 
+ Could result in data becoming unreachable (that's okay for now)


### Phase 3

+ Data redundancy (3 copies since that seems standard'ish)
+ Rebalancing of shards across existing instances (failure/growth scenarios)
  + Frequent check-ins (status/heartbeat) of servers now required
  + Router needs to support timers/events (to do checkins)


### Phase 4-? (not entirely determined/defined)

+ Multiple Services (Profile)
+ Action Support (Campaign -> Profile)
+ Data Redundancy
+ Service Chasing (fail-over, scale up/down, data re-balancing)


  [1]: http://cs.brown.edu/courses/cs227/archives/2012/papers/weaker/cidr07p15.pdf

