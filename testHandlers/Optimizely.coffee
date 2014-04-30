angular.module 'BassetHound.testHandler.Optimizely', ['BassetHound']
    .run (BassetHound, $q) ->
        BassetHound.setTestHandler
            name: "Optimizely"

            activeTests: ->
                experiments = optimizely.data.experiments
                variations = optimizely.data.variations

                return optimizely.data.state.activeExperiments.map (experimentID) ->
                    experiment = experiments[experimentID]

                    experiment.variations = experiment.variation_ids.map (variationID) ->
                        variations[variationID].name

                    return experiment

            registerTest: (name, variations) ->
                deferred = $q.defer()

                # TODO Fix me.

                setTimeout ->
                    deferred.resolve activeVariation
                , 0

                return deferred.promise