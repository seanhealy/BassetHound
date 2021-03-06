// Generated by CoffeeScript 1.6.2
(function() {
  angular.module('BassetHound.trackers.KISSmetrics', ['BassetHound']).run(function(BassetHound) {
    return BassetHound.registerTracker({
      name: 'KISSmetrics',
      track: function(eventName, metadata) {
        return _kmq.push(['record', eventName]);
      },
      setUserProperty: function(metadata) {
        return _kmq.push(['set', metadata]);
      },
      identifyUser: function(identifier) {
        return _kmq.push(['identify', identifier]);
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=KISSmetrics.map
*/
