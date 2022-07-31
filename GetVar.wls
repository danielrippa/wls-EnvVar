
  { args } = Args
  { descriptions, validate-env-name, validate-var-name } = EnvVarArgs
  { get-var } = EnvVar
  { fail, stdout } = Wsh

  do !->

    { var-name, env-name } = args <[ var-name env-name ]> <[]> <[ env-name=user ]> descriptions{ env-name }

    validate-env-name env-name ; validate-var-name env-name, var-name

    stdout get-var env-name, var-name
