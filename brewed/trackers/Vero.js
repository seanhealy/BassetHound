// Generated by CoffeeScript 1.6.2
(function() {
  angular.module('BassetHound.trackers.Vero', ['BassetHound']).run(function(BassetHound) {
    return BassetHound.registerTracker({
      name: 'Vero',
      track: function(eventName, metadata) {
        var combinedMetadata;

        console.log("HERE!");
        combinedMetadata = Object.extended(config.analytics_defaults).clone().merge(metadata);
        return _veroq.push(['track', eventName, combinedMetadata]);
      },
      setUserProperty: function(metadata) {
        var fixedMetadata;

        fixedMetadata = {};
        Object.keys(metadata).forEach(function(key) {
          return fixedMetadata[key.replace(' ', '_')] = metadata[key];
        });
        return _veroq.push(['user', fixedMetadata]);
      },
      identifyUser: function(email) {
        return _veroq.push([
          'user', {
            email: email
          }
        ]);
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=Vero.map
*/