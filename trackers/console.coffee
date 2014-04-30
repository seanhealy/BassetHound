angular.module 'BassetHound.trackers.console', ['BassetHound']
.run (BassetHound) ->
    BassetHound.registerTracker
        name: 'console'

        initialize: ->
            console.log "BassetHound - Console Tracker Initialized"

        track: (eventName, metadata) ->
            console.group()
            console.log "BassetHound - Track Event Name:", eventName
            console.log "BassetHound - Metadata:", metadata
            console.groupEnd()

        setUserProperty: (metadata) ->
            console.group()
            console.log "BassetHound - Set User Property:", metadata
            console.groupEnd()

        identifyUser: (identifier) ->
            console.group()
            console.log "BassetHound - Identify User:", identifier
            console.groupEnd()