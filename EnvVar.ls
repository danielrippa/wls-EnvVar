
  do ->

    environment-names = <[ process system user volatile ]>

    new ActiveXObject 'WScript.Shell'

      environment = -> ..Environment it

      expand = -> ..ExpandEnvironmentStrings it

    get-var = (env-name, var-name) -> (environment env-name) var-name
    set-var = (env-name, var-name, var-value) !->

      env = environment env-name
      name = var-name ; value = var-value

      ``env(name)=value``

    del-var = (env-name, var-name) ->
      try environment env-name .Remove var-name
      (get-var env-name, var-name) is ''

    env-var = -> query = "%#it%" ; value = expand query ; value unless value is query

    expand-env-var = (var-name) ->

      index = var-name.index-of ':'

      if index isnt -1

        [ env-name, var-name ] = var-name.split ':'
        var-value = get-var env-name, var-name

        if var-value is ''
          throw "Environment var '#env-name' does not exist in environment '#env-name'."
        else
          var-value

    expand-var = (var-name) ->

      var-name = var-name.slice 2
      var-name = var-name.slice 0, -1

      index = var-name.index-of ':'

      if index isnt -1
        expand-env-var var-name
      else
        env-var var-name

    expand-vars = (expression) ->

      original-expression = expression

      expanded = ''

      loop

        break if expression.length is 0

        first-index = expression.index-of '${'

        if first-index is -1

          expanded = "#expanded#expression"
          expression = ''

        else

          last-index = expression.index-of '}'
          if last-index isnt -1

            expanded = "#expanded#{ expression.slice 0, first-index }"
            var-name = expression.slice first-index, last-index + 1
            var-value = expand-var var-name

            if var-value is void
              throw "Invalid expandable expression '#var-name' in '#original-expression'."

            expanded = "#expanded#var-value"

            expression = expression.slice last-index + 1
          else
            throw "Missing closing '}' in expandable expression '#original-expression'."

      expanded

    {
      environment-names,
      get-var, set-var, del-var,
      env-var, expand-vars
    }