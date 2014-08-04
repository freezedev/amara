hasModule = !!(module? and module.exports)

do (root = if hasModule then module.exports else @) ->

  defined = []
  modules = {}

  evaluateModules = (ids, callback, after) ->
    ids = [ids] if typeof deps is 'string'

    depList = []
    depLength = ids.length
    depIndex = 0

    for dep, num in ids
      evaluateSingleModule dep, (depResult) ->
        depList[num] = depResult
        depIndex++

        if depIndex is depLength
          if after
            after modules[dep].cache = callback.apply @, depList
          else
            callback.apply @, depList if callback?
    null

  evaluateSingleModule = (id, callback) ->
    return unless modules[id]

    # If cache available, use the cache
    if Object.hasOwnProperty modules[id], 'cache'
      return callback modules[id].cache

    {factory} = modules[id]

    unless modules[id].deps?
      callback modules[id].cache = do ->
        if typeof factory is 'function' then factory.apply @ else factory
    else
      evaluateModules modules[id].deps, factory, callback

  root.define = (id, deps, factory) ->
    return if defined.indexOf(id) > 0

    if Array.isArray deps
      deps = null if deps.length is 0
    else
      [deps, factory] = [null, deps]

    defined.push id
    modules[id] = {deps, factory}

  root.define.amd = true

  # Uncomment this for debug purposes
  #root.modules = modules

  root.require = evaluateModules