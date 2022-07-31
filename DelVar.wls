
  { args } = Args
  { del-var, get-var } = EnvVar
  { descriptions, validate-env-name, validate-var-name } = EnvVarArgs
  { fail } = Wsh

  do !->

    { var-name, env-name } = args <[ var-name env-name ]> <[]> <[ env-name=user ]> descriptions

    validate-env-name env-name ; validate-var-name env-name, var-name

    fail "Unable to remove environment variable '#var-name' in environment '#env-name'.", 3 \
      unless del-var env-name, var-name
