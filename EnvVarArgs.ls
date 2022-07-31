
  do ->

    { fail } = Wsh
    { environment-names } = EnvVar
    { lcase } = Str
    { get-var } = EnvVar

    descriptions =
      env-name: "Environment name. Can be any of: #{ environment-names.join ', ' }. Default value is 'user'."

    validate-env-name = (env-name, errorlevel = 1) !->

      fail "Invalid environment name '#env-name'.\nValid environment names are: #{ environment-names.join ', ' }.", errorlevel \
        unless (lcase env-name) in environment-names

    validate-var-name = (env-name, var-name, errorlevel = 2) !->

      var-value = get-var env-name, var-name

      fail "EnvVar '#var-name' not defined in environment '#env-name'.", errorlevel \
        if var-value is void

    {
      validate-env-name,
      validate-var-name,
      descriptions
    }