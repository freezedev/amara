(function() {
  var hasModule;

  hasModule = !!((typeof module !== "undefined" && module !== null) && module.exports);

  (function(root) {
    var defined, evaluateModules, evaluateSingleModule, modules;
    defined = [];
    modules = {};
    evaluateModules = function(ids, callback, after) {
      var dep, depIndex, depLength, depList, num, _i, _len;
      if (typeof deps === 'string') {
        ids = [ids];
      }
      depList = [];
      depLength = ids.length;
      depIndex = 0;
      for (num = _i = 0, _len = ids.length; _i < _len; num = ++_i) {
        dep = ids[num];
        evaluateSingleModule(dep, function(depResult) {
          depList[num] = depResult;
          depIndex++;
          if (depIndex === depLength) {
            if (after) {
              return after(modules[dep].cache = callback.apply(this, depList));
            } else {
              if (callback != null) {
                return callback.apply(this, depList);
              }
            }
          }
        });
      }
      return null;
    };
    evaluateSingleModule = function(id, callback) {
      var factory;
      if (!modules[id]) {
        return;
      }
      if (Object.hasOwnProperty(modules[id], 'cache')) {
        return callback(modules[id].cache);
      }
      factory = modules[id].factory;
      if (modules[id].deps == null) {
        return callback(modules[id].cache = (function() {
          if (typeof factory === 'function') {
            return factory.apply(this);
          } else {
            return factory;
          }
        })());
      } else {
        return evaluateModules(modules[id].deps, factory, callback);
      }
    };
    root.define = function(id, deps, factory) {
      var _ref;
      if (defined.indexOf(id) > 0) {
        return;
      }
      if (Array.isArray(deps)) {
        if (deps.length === 0) {
          deps = null;
        }
      } else {
        _ref = [null, deps], deps = _ref[0], factory = _ref[1];
      }
      defined.push(id);
      return modules[id] = {
        deps: deps,
        factory: factory
      };
    };
    root.define.amd = true;
    return root.require = evaluateModules;
  })(hasModule ? module.exports : this);

}).call(this);

/*
//@ sourceMappingURL=amara.js.map
*/