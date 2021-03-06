// Generated by CoffeeScript 1.6.2
(function() {
  angular.module('BassetHound.trackers.Optimizely', ['BassetHound']).run(function(BassetHound) {
    return BassetHound.registerTracker({
      name: 'Optimizely',
      track: function(eventName, metadata) {
        return _optimizely.push(['trackEvent', eventName]);
      },
      setUserProperty: function(metadata) {},
      identifyUser: function(email) {}
    });
  });

}).call(this);

/*
//@ sourceMappingURL=Optimizely.map
*/
