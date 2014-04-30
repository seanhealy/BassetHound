angular.module 'BassetHound.trackers.KISSmetrics', ['BassetHound']
    .run (BassetHound) ->
        BassetHound.registerTracker
            name: 'KISSmetrics'

            track: (eventName, metadata) ->
                combinedMetadata = Object.extended(config.analytics_defaults)
                    .clone()
                    .merge(metadata)
                _kmq.push ['record', eventName, combinedMetadata]

            setUserProperty: (metadata) ->
                _kmq.push ['set', metadata]

            identifyUser: (identifier) ->
                _kmq.push ['identify', identifier]