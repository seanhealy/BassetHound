angularModules = [
    'BassetHound'

    'BassetHound.trackers.console'
    'BassetHound.trackers.KISSmetrics'
    # 'BassetHound.trackers.Vero'
    # 'BassetHound.trackers.Optimizely'

    'BassetHound.testHandler.KISSmetrics'
    # 'BassetHound.testHandler.Optimizely'
]

@APP = angular.module('bh.demo', angularModules)

@AppController = ($scope, BassetHound) ->
    BassetHound.track "Visited Page"

    $scope.identifyUser = ->
        BassetHound.identifyUser $scope.name
