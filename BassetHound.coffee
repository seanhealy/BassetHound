#
#
#                                                                                    K
#            ____                     _     _    _                       _          ,KKK
#           |  _ \                   | |   | |  | |                     | |          KKKj
#           | |_) | __ _ ___ ___  ___| |_  | |__| | ___  _   _ _ __   __| |           KKK
#           |  _ < / _` / __/ __|/ _ \ __| |  __  |/ _ \| | | | '_ \ / _` |            KKK
#           | |_) | (_| \__ \__ \  __/ |_  | |  | | (_) | |_| | | | | (_| |            KKK
#           |____/ \__,_|___/___/\___|\__| |_|  |_|\___/ \__,_|_| |_|\__,_|             KKK
#                                                                                       KKK
#                                                                                        KK
#                                                                                        KK
#                                                                                        KK
#                                                                                        KK
#                                                                                       KKK
#                                                                                       KKK
#                                 ,KKKKKKK                                              KKi
#                            KKKKKKKKKKKKKKKKKKKK              GKKKKKKKKKKG            KKK
#                 KKKKKKKKKKKKKKKKKKK  KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK       KKK
#                KKKKKKKKKKKKKKKK          LKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKjKKKKKK
#                KKKKKKKKKj                                                 KKKKKKKKKKK
#               KKK                                                            KKKKKKK
#               KKK
#              KKK   KK
#              KKK   KK
#             KKK    KK                                                           KK
#             KKK    KK     K                                                     KK
#            KKK     KK   KKK                                                    KKK
#            KKK     KK    KKK                                                  KKKK
#            KKK     KK    KKK                                                  KKK
#            KKK     KK     KK                                                 .KK
#            KKL     KK     KKK                                     KKK        KKK
#           KKK      KK     KKK                                KKKKKKKK         KK
#           KKK      KK     KKK                           KKKKKKKKKKKKK         KKK
#          KKK       KK      KK        KKKKKKKKKKKKKKKKKKKKKKKKKKK   KKK        KKKK
#          KKK       KK     ,KKK       KKKKKKKKKKKKKKKKKKKKKK,       KKK         KKK
#         KKK        KK     KKKKK      KKKKKKKKKKKKKKKKKf             KKKK        KK
#         KKK       KKK     KKKKKKK    KKK                             KKKKKKKK   KK
#        KKKKK     KKKK    KKK  KKKK   KKK                              KKKKKKK   KK
#        KKKKKKKK KKKKK  KKKKK  KKKK   KKK                                KKKKK   KK
#          KKKKKKKKKDKKKKKKKK   KKK   KKK                                   KKK   KK
#             KKKKKf KKKKKK    KKK,,,KKK.                                   KKK   KK
#                    KKf      KKKKKKKKKK                                    KKKKKKKK
#                             KKKKKKKKK                                     KKKKKKKK
#
# BassetHound is an Angular module for tracking behaviour. Designed to integrate with
# arbitraty analitics and AB testing tools in a friendly, generic and reusable manner.
#
# @author Sean Healy
#
BassetHound = angular.module 'BassetHound', []

BassetHound.factory 'BassetHound', ($rootScope, $q) ->
    _trackers = []
    _abTestHandler = null
    _abTestStates = {}

    _callDelegate = (delegateAction, args...) ->
        if Object.isFunction delegateAction
            delegateAction(args...)
        else
            console.warn "Delegate Doesn't respond to action."

    _depricatedAction = (action, args...) ->
        if Object.isFunction action
            # console.warn "Call to depricated action."
            action(args...)
        else
            console.error "Action does not exist."

    # Register a BassetHound Tracker
    #
    # @param [Object] BassetHound Tracker Delegate
    registerTracker = (tracker) ->
        _trackers.push tracker
        console.log "BassetHound - Registering Tracker:", tracker.name
        _callDelegate tracker.initialize

    # Set BassetHound's AB Test Handler
    #
    # @param [Object] BassetHound AB Test Handler
    setTestHandler = (testHandler) ->
        if _abTestHandler?
            console.error "BassetHound - AB Test Handler Already Set:", _abTestHandler.name
            return

        console.log "BassetHound - Registering AB Test Handler:", testHandler.name
        _abTestHandler = testHandler

        registerTests _abTestHandler.activeTests()

    ###
    # Events
    ###

    # Track an event
    #
    # @param [String] Event Name
    # @param [Object] Event Metadata
    track = (eventName, metadata) ->
        _callDelegate tracker.track, eventName, metadata for tracker in _trackers

    # Set a Property on a User
    #
    # @param [String] Event Name
    # @param [Object] Event Metadata
    setUserProperty = (propertyData) ->
        _callDelegate tracker.setUserProperty, propertyData for tracker in _trackers

    # Identify a User
    #
    # @param [String] Identifier
    identifyUser = (metadata) ->
        _callDelegate tracker.identifyUser, arguments... for tracker in _trackers

    ###
    # Tests
    ###

    _storeTestState = (name, activeVariation) ->
        _abTestStates[name] = activeVariation
        $rootScope.$broadcast "BassetHound::testStateResolved", { name, activeVariation }

    registerTests = (tests) ->
        for test in tests
            registerTest test.name, test.variations

    registerTest = (name, variations) ->
        sanitizedName = name.underscore().remove(/\W/g)
        _callDelegate _abTestHandler.registerTest, sanitizedName, variations
        .then (activeVariation) ->
            _storeTestState sanitizedName, activeVariation.underscore().remove(/\W/g)
        , (error) ->
            console.error "Yuck!"
            if Object.isObject(variations)
                _storeTestState sanitizedName, Object.keys(variations).first().underscore().remove(/\W/g)
            else
                _storeTestState sanitizedName, variations.first().underscore().remove(/\W/g)

    publicActions = {
        # Debug
        _debug: ->
            return {
                _trackers
                _abTestHandler
                _abTestStates
            }

        # Settings
        registerTracker
        setTestHandler

        # Events
        track
        setUserProperty
        identifyUser

        # AB Testing
        registerTest

        # Legacy Actions
        set: -> _depricatedAction @setUserProperty, arguments
        identify: -> _depricatedAction @identifyUser, arguments
    }

    window.AngularTunnels.BassetHound = publicActions

    return publicActions

BassetHound.directive 'bhTrack', (BassetHound) ->
    return (scope, element, attrs) ->
        eventName = ""

        attrs.$observe 'bhTrack', (value) ->
            eventName = value

        element.on 'click', ->
            BassetHound.track eventName

BassetHound.directive 'bhViewed', (BassetHound) ->
    return (scope, element, attrs) ->
        eventName = ""

        attrs.$observe 'bhViewed', (value) ->
            eventName = value

        element.on 'click', ->
            BassetHound.track "Viewed #{eventName}"

BassetHound.directive 'bhTestClassList', (BassetHound, $rootScope) ->
    return (scope, element, attrs) ->
        $rootScope.$on 'BassetHound::testStateResolved', (event, test) ->
            element.addClass "bh-#{test.name}-#{test.activeVariation}"

BassetHound.directive 'bhIf', (BassetHound, $rootScope) ->
    return (scope, element, attrs) ->
        element.hide()

        attrs.$observe 'bhIf', (condition) ->
            if Object.isString condition
                parsedCondition = condition.split('is').map((el) -> el.trim())

                if parsedCondition? and Object.isArray(parsedCondition) and parsedCondition.length is 2
                    [goalTestName, goalTestVariation] = parsedCondition

                    $rootScope.$on 'BassetHound::testStateResolved', (event, test) ->
                        resolvedTestName = test.name
                        resolvedTestVariation = test.activeVariation

                        if goalTestName == resolvedTestName
                            if goalTestVariation == resolvedTestVariation
                                element.show()
                            else
                                element.remove()

                else
                    console.error "BassetHound - Invalid Test Condition:", condition
            else
                console.error "BassetHound - Invalid Test Condition:", condition











