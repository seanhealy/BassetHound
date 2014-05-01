angular.module('BassetHound.trackers.KISSmetrics', ['BassetHound'])
    .run (BassetHound) ->
        BassetHound.registerTracker
            name: 'KISSmetrics'

            track: (eventName, metadata) ->
                _kmq.push ['record', eventName]

            setUserProperty: (metadata) ->
                _kmq.push ['set', metadata]

            identifyUser: (identifier) ->
                _kmq.push ['identify', identifier]