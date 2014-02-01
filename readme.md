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



----


## Random Ideas

### ORM

It might make sense to add a simple ORM type thing (not really an ORM)
on top of the simple DB layer that we're using. In general it would need
to:

+ Specify a schema for a given service (campaign, profile, advertiser, etc)
+ Be able to perform an update with a combined object (campaign-profile)
  and for a given schema and return a set of objects that can be applied
  to activities (in the queue-thing sense of the world) for other services.
  This updated object would not have an updated reference to the parent ID
  which I assume would be necessary.

The general idea of what I'm thinking is something along the lines of

```ruby
class Schema::Campaign < Schema::Base
  fields :id, :name
  key :id
  
  child_relation :profile, Schema::Profile
end

class Schema::Profile < Schema::Base
  fields :id, :os_targets, :device_targets, ...
  key :id

  parent_relation :campaign, Schema::Campaign
end

# usage
child_updates = db.update(Schema::Campaign).with(data).commit

child_updates.each { |c| service_dispatcher.send(c) }
```


  [1]: http://cs.brown.edu/courses/cs227/archives/2012/papers/weaker/cidr07p15.pdf

