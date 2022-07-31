
  { args } = Args
  { expand-vars } = EnvVar
  { stdout, fail } = Wsh

  do !->

    descriptions =

      exp:

        * "Expression to be expanded."
          "  Must be enclosed in double quotes if it contains spaces."
          ""
          "Syntax:"
          "  Specific environment variable:"
          "    ${path:user} expands to the 'path' value in the 'user' environment."
          "  Expanded value:"
          "    ${path} expands the combined value in all available environments."
        |> (.join '\n')

    { exp } = args <[ exp ]>,,, descriptions

    try
      expanded = expand-vars exp
    catch message
      fail message

    stdout expanded