
  { args } = Args
  { descriptions, validate-env-name } = EnvVarArgs
  { get-var, set-var } = EnvVar

  do ->

    { var-name, var-value, env-name } = args <[ var-name var-value env-name ]> <[]> <[ env-name=user ]> descriptions{ env-name }

    validate-env-name env-name

    previous-value = get-var env-name, var-name

    set-var env-name, var-name, "#previous-value#var-value"


