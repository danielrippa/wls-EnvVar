
  { args } = Args
  { descriptions, validate-env-name } = EnvVarArgs
  { set-var } = EnvVar

  do ->

    { var-name, var-value, env-name } = args <[ var-name var-value env-name ]> <[]> <[ env-name=user ]> descriptions{ env-name }

    validate-env-name env-name

    set-var env-name, var-name, var-value


