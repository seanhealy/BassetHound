angular.module('BassetHound.trackers.Optimizely', ['BassetHound'])
    .run (BassetHound) ->
        BassetHound.registerTracker
            name: 'Optimizely'

            track: (eventName, metadata) ->
                _optimizely.push ['trackEvent', eventName]

            setUserProperty: (metadata) ->
                # Optimizely has no concept of users so don't do anything here.
                return

            identifyUser: (email) ->
                # Optimizely has no concept of users so don't do anything here.
                return