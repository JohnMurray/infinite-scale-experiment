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
+ Service/Data Sharding
+ Simple Service Locater (routing)

### Phase 2

+ Multiple Services (Profile)
+ Action Support (Campaign -> Profile)

### Phase 3

+ Data Redundancy
+ Service Chasing (failed instance fail-over)

### Phase 4

+ Service Discovery (new server, re-balancing, service-chasing for rebalanced 
  servers)

  [1]: http://cs.brown.edu/courses/cs227/archives/2012/papers/weaker/cidr07p15.pdf

