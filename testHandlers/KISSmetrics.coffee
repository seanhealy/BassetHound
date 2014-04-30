angular.module 'BassetHound.testHandler.KISSmetrics', ['BassetHound']
    .run (BassetHound, $q) ->
        BassetHound.setTestHandler
            name: "KISSmetrics"

            activeTests: ->
                return [
                        name: "Sample Test One"
                        variations: [
                            "caseOne"
                            "caseTwo"
                        ]
                    ,
                        name: "Sample Test Two"
                        variations: [
                            "caseOne"
                            "caseTwo"
                        ]
                ]

            registerTest: (name, variations) ->
                deferred = $q.defer()

                abTimeout = setTimeout ->
                    deferred.reject "AB Test Registration Timed Out"
                , 6000

                _kmq.push ->
                    activeVariation = KM.ab name, variations
                    deferred.resolve activeVariation

                return deferred.promise

