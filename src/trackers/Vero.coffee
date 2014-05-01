angular.module('BassetHound.trackers.Vero', ['BassetHound'])
    .run (BassetHound) ->
        BassetHound.registerTracker
            name: 'Vero'

            track: (eventName, metadata) ->
                console.log "HERE!"
                combinedMetadata = Object.extended(config.analytics_defaults)
                    .clone()
                    .merge(metadata)
                _veroq.push ['track', eventName, combinedMetadata]

            setUserProperty: (metadata) ->
                # Vero expects that property names not include spaces, so replace them with underscores
                fixedMetadata = {}
                Object.keys(metadata).forEach (key) ->
                    fixedMetadata[key.replace( ' ', '_')] = metadata[key]

                _veroq.push ['user', fixedMetadata]

            identifyUser: (email) ->
                _veroq.push ['user', {email: email}]